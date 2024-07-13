FROM php:8.3.2-fpm-alpine3.19

RUN apk --update --no-cache add \
            bash \
            curl \
            ca-certificates \
            gnupg \
            git \
            npm \
            unzip \
            libzip-dev \
            libpng-dev \
            autoconf \
            busybox-static \
            linux-headers \
            nodejs~=20 \
            patch \
        && git clone https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis \
        && docker-php-ext-install \
            zip \
            pdo_mysql \
            sockets \
            redis \
        && docker-php-ext-enable opcache \
        && rm -rf /var/cache/apk/*

COPY --from=composer:2.6.6 /usr/bin/composer /usr/bin/composer

RUN mkdir /app
WORKDIR /app


COPY .docker/pro/app/php.ini /usr/local/etc/php/php.ini

COPY ./src /app

RUN ls /app

COPY .docker/pro/app/www.conf.patch /usr/local/etc/php-fpm.d/www.conf.patch

RUN patch /usr/local/etc/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf.patch

RUN composer install

RUN chmod -R a+w /app/storage /app/bootstrap/cache

