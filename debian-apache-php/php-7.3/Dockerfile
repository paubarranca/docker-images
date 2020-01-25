FROM debian:10.2-slim

MAINTAINER Pau Barranca <paubarrancamon@gmail.com>
LABEL name="paubarranca/debian-apache-php:v7.3"

ENV DEBIAN_FRONTEND=noninteractive

# Default jinja env variables
ENV \ 
   PHP_V="7.3"                              \
   KEEPALIVE_MAX_REQUESTS="10000"           \
   KEEPALIVE_TIMEOUT="650"                  \
   APACHE_ENABLE_CORS="false"               \
   APACHE_ENABLE_CSP="false"                \
   APACHE_CSP_HEADER="upgrade-insecure-requests; default-src * data: 'unsafe-eval' 'unsafe-inline'" \
   APACHE_MAX_REQUEST_WORKERS="250"         \
   APACHE_START_SERVERS="2"                 \
   APACHE_DOCUMENTROOT="/var/www/httpdocs/" \
   APACHE_DIRECTORY_INDEX="index.php"       \
   APACHE_ENABLE_BADBOTS="false"            \
   APACHE_ENABLE_CSP="false"                \
   PHP_MEM_LIMIT="128M"                     \
   PHP_DISPLAY_ERRORS="on"                  \
   PHP_ERROR_LOG_PATH="/dev/stdout"         \
   PHP_MAX_EXECUTION_TIME="60"              

# Install apache, PHP & jinja
RUN apt update && apt-get install -yq --no-install-recommends \
    apt-utils wget python3-pip apt-transport-https supervisor && \
    pip3 install jinja2 j2cli pip setuptools wheel && \
    apt install -yq --no-install-recommends \
    apache2 libapache2-mod-authnz-external \
    php${PHP_V} php${PHP_V}-fpm \
    php${PHP_V}-common \
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

# Delete default apache site conf
RUN rm -f /etc/apache2/sites-available/000-default.conf \
    rm -f /etc/apache2/sites-available/default-ssl.conf \
    rm -rf /var/www/html

# PHP module it's not compatible with mpm_event module
RUN a2dismod php${PHP_V} && \
    a2dismod mpm_prefork && \
    a2enmod mpm_event && \
    a2enmod proxy ssl proxy_http proxy_balancer rewrite headers actions proxy_fcgi alias expires auth_basic remoteip


# Set Badbots blacklist
RUN mkdir /etc/apache2/custom.d && \
   wget https://github.com/mitchellkrogza/apache-ultimate-bad-bot-blocker/raw/master/Apache_2.4/custom.d/globalblacklist.conf -O /etc/apache2/custom.d/globalblacklist.conf && \
   wget https://raw.githubusercontent.com/mitchellkrogza/apache-ultimate-bad-bot-blocker/master/Apache_2.4/custom.d/bad-referrer-words.conf -O /etc/apache2/custom.d/bad-referrer-words.conf && \
   wget https://github.com/mitchellkrogza/apache-ultimate-bad-bot-blocker/raw/master/Apache_2.4/custom.d/blacklist-ips.conf -O /etc/apache2/custom.d/blacklist-ips.conf && \
   touch /etc/apache2/custom.d/blacklist-user-agents.conf \
         /etc/apache2/custom.d/whitelist-domains.conf \
         /etc/apache2/custom.d/bad-referrer-words.conf \
         /etc/apache2/custom.d/whitelist-ips.conf

# Copy content
RUN mkdir -p /usr/local/scripts/ && \
    mkdir -p /var/run/php
ADD /content/scripts/ /usr/local/scripts/
ADD /content/jinja2/ /root/jinja2/
ADD /content/config/supervisord.conf /etc/supervisor/supervisord.conf
ADD /content/entrypoint.sh /root/entrypoint.sh
RUN chmod 755 /root/entrypoint.sh

# Implement health-check
HEALTHCHECK --retries=3 --interval=5s --timeout=3s \
    CMD /usr/bin/php${PHP_V} /usr/local/scripts/health-check.php

WORKDIR ${APACHE_DOCUMENTROOT}

EXPOSE 80

ENTRYPOINT ["/root/entrypoint.sh"]