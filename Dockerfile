FROM ubuntu:focal

MAINTAINER jason.everling@gmail.com

# Values are 7.0 or 7.2
ARG PHP=7.2

# Timezaone as in http://manpages.ubuntu.com/manpages/focal/man3/DateTime::TimeZone::Catalog.3pm.html
ARG TZ=America/North_Dakota/Center

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get update && apt-get install --no-install-recommends -y \
    apt-transport-https \
    software-properties-common \
    aspell \
    ca-certificates \
    clamav \
    clamav-daemon \
    curl \
    ghostscript \
    libaio1 \
    libcurl4 \
    libgss3 \
    libmcrypt-dev \
    libxml2 \
    libxslt1.1 \
    libzip-dev \
    locales \
    sassc \
    unoconv \
    unixodbc \
    unixodbc-dev \
    unzip \
    wget \
    zip && \
    add-apt-repository ppa:ondrej/php -y && \
    add-apt-repository ppa:libreoffice/ppa -y && \
    apt-get update && \
    apt-get install -y \
    apache2 \
    libapache2-mod-php$PHP \
    libreoffice \
    libmemcached-dev \
    libmemcached11 \
    libmemcachedutil2 \
    php$PHP-bcmath \
    php$PHP-curl \
    php$PHP-cli \
    php$PHP-dev \
    php$PHP-gd \
    php$PHP-intl \
    php$PHP-json \
    php$PHP-ldap \
    php$PHP-mbstring \
    php$PHP-mysql \
    php$PHP-opcache \
    php$PHP-pspell \
    php$PHP-readline \
    php$PHP-soap \
    php$PHP-xml \
    php$PHP-xmlrpc \
    php$PHP-zip \
    php-pear && \
    pecl install \
    memcached \
    igbinary \
    sqlsrv-5.3.0 \
    pdo_sqlsrv-5.3.0 && \
    service apache2 stop

COPY etc/apache2/ /etc/apache2/
COPY etc/cron.hourly/freshclam.sh /etc/cron.hourly/freshclam.sh
COPY etc/php/ /etc/php/
COPY etc/ssl/ /etc/ssl/

RUN a2enmod php$PHP ssl rewrite

# Apache uploads, for Moodle/Wordpress Data
RUN mkdir /opt/data && \
    chown -R www-data:www-data /opt/data && \
    chmod -R 0777 /opt/data && \
    chmod -R 0755 /etc/cron.hourly/freshclam.sh && \
    mkdir /var/www/.config && \
    chown -R www-data:www-data /var/www/.config

VOLUME ["/opt/data"]
VOLUME ["/var/log/apache2"]
VOLUME ["/var/www/html"]

EXPOSE 80 443

CMD ["apachectl", "-k", "start", "-DFOREGROUND"]
