FROM ubuntu:focal

MAINTAINER jason.everling@gmail.com

# Values are 7.0 or 7.2
ARG PHP=7.0

# Timezaone as in http://manpages.ubuntu.com/manpages/focal/man3/DateTime::TimeZone::Catalog.3pm.html
ARG TZ=America/North_Dakota/Center

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get update && apt-get install --no-install-recommends -y \
    apt-transport-https \
    software-properties-common \
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
    unixodbc \
    unzip \
    zip && \
    add-apt-repository ppa:ondrej/php -y && \
    apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    curl \
    apache2 \
    libapache2-mod-php$PHP \
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
    sqlsrv \
    pdo_sqlsrv && \
    service apache2 stop


COPY etc/apache2/ /etc/apache2/
COPY etc/php/ /etc/php/
COPY etc/ssl/ /etc/ssl/

RUN a2enmod php$PHP ssl rewrite

RUN mkdir /opt/data && chown -R www-data:www-data /opt/data && chmod -R 0777 /opt/data

VOLUME ["/opt/data"]
VOLUME ["/var/log/apache2"]
VOLUME ["/var/www/html"]

EXPOSE 80 443

CMD ["apachectl", "-k", "start", "-DFOREGROUND"]
