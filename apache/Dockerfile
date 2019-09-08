FROM debian:10

MAINTAINER Pau Barranca <paubarrancamon@gmail.com>
LABEL name="paubarranca/debian-apache-php:latest"

ENV DEBIAN_FRONTEND=noninteractive
ENV PHP_V=7.3

# Install dependencies
RUN apt -y --no-install-recommends install apt-transport-https ca-certificates && \
apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    apache2 \
    libapache2-mod-${PHP_V} \
    php${PHP_V}-cli \
    php${PHP_V}-json \
    php${PHP_V}-curl \
    php${PHP_V}-fpm \
    php${PHP_V}-gd \
    php${PHP_V}-ldap \
    php${PHP_V}-mbstring \
    php${PHP_V}-mysql \
    php${PHP_V}-soap \
    php${PHP_V}-sqlite3 \
    php${PHP_V}-xml \
    php${PHP_V}-zip \
    php${PHP_V}-intl \
    php-imagick \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

    # Enforce apache to send logs to stdout
    a2disconf other-vhosts-access-log && \
    ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stdout /var/log/apache2/error.log && \

RUN rm -f /etc/apache2/sites-available/000-default.conf
COPY /apache2/000-default.conf /etc/apache2/sites-available/

WORKDIR /var/www/html/httpdocs

HEALTHCHECK --retries=3 --interval=5s --timeout=3s \
    curl -f http://localhost || exit 1

EXPOSE 80

CMD apachectl -D FOREGROUND 
