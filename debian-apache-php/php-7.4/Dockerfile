FROM debian:10.2-slim

MAINTAINER Pau Barranca <paubarrancamon@gmail.com>
LABEL name="paubarranca/debian-apache-php:v7.4"

ENV DEBIAN_FRONTEND=noninteractive
ENV PHP_V=7.4

# Install dependencies
RUN apt-get update && \
    apt -y --no-install-recommends install lsb-release curl wget ca-certificates

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

RUN apt-get update && \
    apt -y --no-install-recommends install php${PHP_V} \
    apache2 libapache2-mod-authnz-external \
    libapache2-mod-php${PHP_V} \
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
    && apt-get clean && rm -rf /var/lib/apt/lists/* \

    # Install PHP composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \

    # Enforce apache to send logs to stdout
    ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stdout /var/log/apache2/error.log

# Copy modified vHost
RUN rm -f /etc/apache2/sites-available/000-default.conf \
    rm -f /etc/apache2/sites-available/default-ssl.conf \
    rm -rf /var/www/html
    
COPY /content/000-default.conf /etc/apache2/sites-available/

RUN a2dissite 000-default
RUN a2ensite 000-default.conf

# Implement health-check
RUN mkdir -p /usr/local/scripts/
COPY /content/health-check.php /usr/local/scripts/

HEALTHCHECK --retries=3 --interval=5s --timeout=3s \
    CMD /usr/bin/php${PHP_V} /usr/local/scripts/health-check.php

WORKDIR /var/www/httpdocs

EXPOSE 80

CMD apachectl -D FOREGROUND 