# syntax=docker/dockerfile:1.7

ARG PHP_VERSION=8.2

FROM php:${PHP_VERSION}-fpm-bullseye AS base

# System deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    git unzip libicu-dev libzip-dev libcurl4-openssl-dev libonig-dev libxml2-dev \
 && docker-php-ext-configure intl \
 && docker-php-ext-install -j"$(nproc)" intl pdo_mysql opcache zip sysvsem \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# PHP settings (you create this file below)
# TODO Fix
#COPY .docker/php/conf.d/laravel.ini /usr/local/etc/php/conf.d/zz-laravel.ini

WORKDIR /var/www/html

RUN git config --system --add safe.directory /var/www/html

# Copy project (simple & robust; best compatibility with Composer auto-scripts)
COPY . .

ENV COMPOSER_HOME=/composer
ENV COMPOSER_CACHE_DIR=/composer/cache
RUN mkdir -p /composer/cache && chown -R www-data:www-data /composer

# Permissions (Symfony writes to var/cache)
RUN mkdir -p /var/www/html/var && chown -R www-data:www-data /var/www/html/var


# Install dependencies (prod by default). Uses cache for speed.
ARG APP_ENV=prod
#ARG APP_ENV=local
ENV APP_ENV=${APP_ENV} APP_DEBUG=0 COMPOSER_ALLOW_SUPERUSER=1
RUN --mount=type=cache,target=/root/.composer/cache \
    if [ "$APP_ENV" = "prod" ]; then \
        composer install --no-dev --prefer-dist --no-progress --no-interaction --optimize-autoloader; \
    else \
        composer install --prefer-dist --no-progress --no-interaction; \
    fi

RUN composer global require laravel/installer


RUN apt-get update && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

#RUN cp .env.example .env
#
USER root
RUN mkdir -p /var/www/.npm && chown -R www-data:www-data /var/www/.npm
RUN chown -R www-data:www-data /var/www/html

USER root
COPY package.json package-lock.json* ./
RUN npm install

COPY . .

RUN chown -R www-data:www-data /var/www/html

USER www-data
RUN npm run build

USER www-data

EXPOSE 9000
CMD ["php-fpm"]

# --- Optional dev target with Xdebug --------------------
FROM base AS dev
USER root
RUN pecl install xdebug && docker-php-ext-enable xdebug
ENV APP_ENV=local APP_DEBUG=1
RUN --mount=type=cache,target=/root/.composer/cache \
    composer install --prefer-dist --no-progress --no-interaction
USER www-data
CMD ["php-fpm"]
