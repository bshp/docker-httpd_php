FROM ubuntu:focal

MAINTAINER jason.everling@gmail.com

ENV PHP_VER=7.0
ENV TZ=America/North_Dakota/Center

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
    libapache2-mod-php$PHP_VER \
    libmemcached-dev \
    libmemcached11 \
    libmemcachedutil2 \
    php$PHP_VER-bcmath \
    php$PHP_VER-curl \
    php$PHP_VER-cli \
    php$PHP_VER-dev \
    php$PHP_VER-gd \
    php$PHP_VER-intl \
    php$PHP_VER-json \
    php$PHP_VER-ldap \
    php$PHP_VER-mbstring \
    php$PHP_VER-mysql \
    php$PHP_VER-opcache \
    php$PHP_VER-pspell \
    php$PHP_VER-readline \
    php$PHP_VER-soap \
    php$PHP_VER-xml \
    php$PHP_VER-xmlrpc \
    php$PHP_VER-zip \
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

RUN a2enmod php$PHP_VER ssl rewrite

VOLUME ["/var/log/apache2"]
VOLUME ["/var/www/html"]

EXPOSE 80 443

CMD ["apachectl", "-k", "start", "-DFOREGROUND"]
