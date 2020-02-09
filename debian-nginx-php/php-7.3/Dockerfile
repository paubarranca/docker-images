FROM debian:buster-slim

MAINTAINER Pau Barranca <paubarrancamon@gmail.com>
LABEL name="paubarranca/debian-nginx-php:v7.3"

ENV DEBIAN_FRONTEND=noninteractive
ENV BUILD_PACKAGES="curl gcc make autoconf wget"

# Default jinja env variables
ENV \ 
   PHP_V="7.3"                              \
   PHP_MEM_LIMIT="128M"                     \
   PHP_DISPLAY_ERRORS="on"                  \
   PHP_ERROR_LOG_PATH="/dev/stdout"         \
   PHP_MAX_EXECUTION_TIME="60"              \
   NGINX_DOCUMENTROOT="/var/www/httpdocs"   \
         

# Install nginx, PHP & jinja
RUN apt update && apt install -yq --no-install-recommends \
    ${BUILD_PACKAGES} gnupg2 wget apt-transport-https lsb-release ca-certificates nginx nginx-common libnginx-mod-http-geoip libgeoip1 supervisor && \
    php${PHP_V} php${PHP_V}-fpm \
    php${PHP_V}-common \
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
    php${PHP_V}-cgi \
    php-imagick \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \

    # Install PHP composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \

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