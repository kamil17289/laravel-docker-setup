FROM php:8.4-fpm-bullseye

ARG user
ARG uid

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libmemcached-dev \
    zip \
    nano

RUN pecl install memcached
RUN pecl install xdebug

RUN docker-php-ext-enable memcached

RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    intl

RUN useradd -G www-data,root -u $uid -d /home/$user $user

RUN mkdir -p /home/$user/.composer

RUN chown -R $user:$user /home/$user

COPY ./composer-install.sh /home/$user/composer-install.sh

RUN chmod a+x /home/$user/composer-install.sh

RUN /home/$user/composer-install.sh

WORKDIR /var/www

USER $user