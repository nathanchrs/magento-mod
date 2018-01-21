FROM php:7.1-fpm-alpine

# add PHP extensions

# OpenSSL
RUN apk update && apk add openssl

# PHP
# intl
RUN apk update \
	&& apk add icu-dev \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install intl

# xml
RUN apk update \
	&& apk add \
	libxml2-dev \
	libxslt-dev \
	&& docker-php-ext-install \
		dom \
		xmlrpc \
		xsl

# images

RUN apk update \
	&& apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev && \
  	docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  docker-php-ext-install -j${NPROC} gd && \
  apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

#database
RUN docker-php-ext-install \
	mysqli \
	pdo \
	pdo_mysql

# mcrypt
RUN apk update \
	&& apk add libmcrypt-dev \
	&& docker-php-ext-install mcrypt

# strings
RUN apk update \
	&& apk add --no-cache gettext-dev \
	&& docker-php-ext-install \
	gettext \
	mbstring

# compression
RUN apk update \
	&& apk add \
	bzip2-dev \
	zlib-dev \
	&& docker-php-ext-install \
		zip \
		bz2

# curl
RUN apk update \
	&& apk add openssl-dev curl-dev curl

# others
RUN docker-php-ext-install bcmath curl hash simplexml soap xml json iconv

# Set PHP options
COPY ./php.ini /usr/local/etc/php/

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Create app directory and set as working directory
RUN mkdir -p /opt/magento
WORKDIR /opt/magento

# Set permission for magento directory
RUN chown -R www-data:www-data /opt/magento

# Use www-data user
USER www-data

# Copy app source to container
COPY --chown=www-data:www-data . /opt/magento

# Set data directory permissions
# RUN chmod -R 0755 /opt/magento/vendor
RUN chmod -R 0755 /opt/magento/app/etc
RUN chmod -R 0755 /opt/magento/pub/static
RUN chmod -R 0755 /opt/magento/var
RUN chmod -R 0755 /opt/magento/generated

# Install dependencies
RUN composer install

EXPOSE 9000
CMD ["php-fpm"]
