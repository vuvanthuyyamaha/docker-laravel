# Using image php:8.1-fpm-alpine
# https://github.com/docker-library/php/blob/master/8.1/alpine3.16/fpm/Dockerfile

ARG ARG_PHP_VERSION=8.1
FROM php:${ARG_PHP_VERSION}-fpm-alpine

LABEL maintainer="JohnVu <vuvanthuyyamaha@gmail.com>"

ARG ARG_TZ=UTC
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=${ARG_TZ}

# OK Config timezone
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# Install system dependencies
RUN set -eux; \
    \
    # Use the default production configuration and set the php_ini
    cp -v ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini; \
    \
    apk update; \
    \
    apk upgrade;

# Install dev dependencies
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS;

# OK Install production dependencies
RUN apk add --no-cache --update \
    openrc \
    bash \
    vim nano \
    wget curl \
    zip unzip \
    tzdata \
    git \
    openssl \
    mariadb-client mysql-client;

# OK Install bzip2 extension.
RUN apk add --no-cache --virtual .bz2-build-deps bzip2-dev; \
    apk add --no-cache --update libbz2; \
    docker-php-ext-configure bz2 --with-bz2; \
    docker-php-ext-install -j$(nproc) bz2; \
    apk del -f --purge --no-network .bz2-build-deps;

# OK Install bcmath extension.
RUN docker-php-ext-configure bcmath --enable-bcmath; \
    docker-php-ext-install -j$(nproc) bcmath;

# OK Install intl(Internationalization) extension.
RUN apk add --no-cache --virtual .intl-build-deps icu-dev; \
    apk add --no-cache --update icu; \
    docker-php-ext-configure intl --enable-intl; \
    docker-php-ext-install -j$(nproc) intl; \
    apk del -f --purge --no-network .intl-build-deps;

# OK Install zip extension.
RUN apk add --no-cache --virtual .zip-build-deps libzip-dev; \
    apk add --no-cache --update libzip; \
    docker-php-ext-configure zip --with-zip; \
    docker-php-ext-install -j$(nproc) zip; \
    apk del -f --purge --no-network .zip-build-deps;

# OK Install pcntl(Process Control) extension.
RUN docker-php-ext-configure pcntl --enable-pcntl; \
    docker-php-ext-install -j$(nproc) pcntl;

# OK Install mcrypt extension.
RUN apk add --no-cache --virtual .mcrypt-build-deps libmcrypt-dev; \
    apk add --no-cache --update libmcrypt; \
    pecl install mcrypt; \
    docker-php-ext-enable mcrypt; \
    apk del -f --purge --no-network .mcrypt-build-deps;

# OK Install xsl extension. (require libxml extension)
RUN apk add --no-cache --virtual .xsl-build-deps libxslt-dev; \
    apk add --no-cache --update libxslt; \
    docker-php-ext-configure xsl --with-xsl; \
    docker-php-ext-install -j$(nproc) xsl; \
    apk del -f --purge --no-network .xsl-build-deps;

# OK Install opcache extension.
RUN docker-php-ext-configure opcache --enable-opcache; \
    docker-php-ext-install -j$(nproc) opcache;

# Ok Install sockets extension.
RUN docker-php-ext-configure sockets --enable-sockets; \
    docker-php-ext-install -j$(nproc) sockets;

# OK Install gd extension.
RUN apk add --no-cache --virtual .gd-build-deps gd-dev zlib-dev libpng-dev libjpeg-turbo-dev freetype-dev libwebp-dev libavif-dev libxpm-dev; \
    apk add --no-cache --update libgd gd zlib libpng libjpeg-turbo freetype libwebp libavif libxpm; \
    docker-php-ext-configure gd --enable-gd --with-jpeg --with-freetype --with-webp --with-xpm --enable-gd-jis-conv; \
    docker-php-ext-install -j$(nproc) gd; \
    apk del -f --purge --no-network .gd-build-deps;

# OK Install exif extension. (require mbstring extension)
RUN docker-php-ext-configure exif --enable-exif; \
    docker-php-ext-install -j$(nproc) exif;

# OK Install imagick extension.
RUN apk add --no-cache --virtual .imagick-build-deps imagemagick-dev; \
    apk add --no-cache --update imagemagick libgomp; \
    pecl install imagick; \
    docker-php-ext-enable imagick; \
    apk del -f --purge --no-network .imagick-build-deps;

# OK Install pdo_pgsql with pgsql extension.
RUN apk add --no-cache --virtual .pgsql-build-deps libpq-dev; \
    apk add --no-cache --update libpq; \
    docker-php-ext-configure pgsql --with-pgsql; \
    docker-php-ext-install -j$(nproc) pgsql; \
    docker-php-ext-configure pdo_pgsql --with-pdo-pgsql=pgsql; \
    docker-php-ext-install -j$(nproc) pdo_pgsql; \
    apk del -f --purge --no-network .pgsql-build-deps;

# OK Install mysqli/pdo_mysql with mysqlnd extension.
RUN docker-php-ext-configure mysqli --with-mysqli=mysqlnd; \
    docker-php-ext-install -j$(nproc) mysqli; \
    docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd; \
    docker-php-ext-install -j$(nproc) pdo_mysql;

# OK Install mongodb extension.
RUN pecl install mongodb; \
    docker-php-ext-enable mongodb;

# OK Install igbinary extension. (handler Session)
RUN pecl install igbinary; \
    docker-php-ext-enable igbinary;

# OK Install redis extension. (require json/igbinary extension)
RUN pecl install --nobuild redis; \
    cd "$(pecl config-get temp_dir)/redis"; \
    docker-php-ext-configure "$(pecl config-get temp_dir)/redis" --enable-redis-json --enable-redis-igbinary; \
    docker-php-ext-install "$(pecl config-get temp_dir)/redis";

# OK Install memcached extension. (require json/session/igbinary extension)
RUN apk add --no-cache --virtual .memcached-build-deps libmemcached-dev zlib-dev cyrus-sasl-dev; \
    apk add --no-cache --update libmemcached libmemcached-libs zlib libsasl gdbm; \
    pecl install --nobuild memcached; \
    cd "$(pecl config-get temp_dir)/memcached"; \
    docker-php-ext-configure "$(pecl config-get temp_dir)/memcached" --enable-memcached-session --enable-memcached-igbinary --enable-memcached-json; \
    docker-php-ext-install "$(pecl config-get temp_dir)/memcached"; \
    apk del -f --purge --no-network .memcached-build-deps;

# Ok Install event extension. (require openssl/sockets extension)
RUN apk add --no-cache --virtual .event-build-deps libevent-dev openssl-dev; \
    apk add --no-cache --update libevent openssl; \
    pecl install --nobuild event; \
    cd "$(pecl config-get temp_dir)/event"; \
    docker-php-ext-configure "$(pecl config-get temp_dir)/event" --enable-event-sockets --with-event-openssl; \
    docker-php-ext-install --ini-name zz-event.ini "$(pecl config-get temp_dir)/event"; \
    apk del -f --purge --no-network .event-build-deps;

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer;

# Create log folder
RUN mkdir -p /var/log/php-fpm; chmod 777 /var/log/php-fpm;

# Cleanup: build deps and cache.
RUN apk del -f --purge --no-network .build-deps; \
    # update pecl channel definitions
    pecl update-channels; \
    rm -rf /tmp/pear ~/.pearrc; \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /usr/src/* /var/lib/apt/lists/*; \
    composer clear-cache;

# Copy PHP.ini settings to the container
COPY config/* $PHP_INI_DIR/conf.d/

# Change default shell for root user.
RUN sed -i "s|root:/bin/ash|root:/bin/bash|i" /etc/passwd
