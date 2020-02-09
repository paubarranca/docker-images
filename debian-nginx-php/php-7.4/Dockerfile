FROM debian:buster-slim

MAINTAINER Pau Barranca <paubarrancamon@gmail.com>
LABEL name="paubarranca/debian-nginx-php:v7.3"

ENV DEBIAN_FRONTEND=noninteractive

# Default jinja env variables
ENV \ 
   PHP_V="7.4"                              \
   PHP_MEM_LIMIT="128M"                     \
   PHP_DISPLAY_ERRORS="on"                  \
   PHP_ERROR_LOG_PATH="/dev/stdout"         \
   PHP_MAX_EXECUTION_TIME="60"              \
   NGINX_DOCUMENTROOT="/var/www/httpdocs/"  \
   NGINX_WORKER_PROCESSES="auto"            \
   NGINX_WORKER_CONNECTIONS="4096"          \
   KEEPALIVE_TIMEOUT="65"                   \
   NGINX_ENABLE_BADBOTS="false"             \
   NGINX_PROXY="false"
   # NGINX_PROXY_ENABLE_STATIC_CONTENT
   # NGINX_PROXY_STATIC_CONTENT_PATH
   # NGINX_PROXY_PASS_HOST
   # NGINX_PROXY_LOCAL_PATH
   # NGINX_PROXY_LOCAL_CONTENT_PATH
   # NGINX_PROXY_PASS_PATH

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
      
# Install nginx, PHP & jinja
RUN apt update && apt install -yq --no-install-recommends \
    curl wget apt-utils gnupg2 python3-pip apt-transport-https lsb-release ca-certificates supervisor && \
    pip3 install jinja2 j2cli pip setuptools wheel && \
    apt install -yq --no-install-recommends \
    nginx nginx-common libnginx-mod-http-geoip libgeoip1 \
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

    # Enforce nginx to send logs to stdout
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stdout /var/log/nginx/error.log

# Set Badbots blacklist
RUN mkdir -p /etc/nginx/bots.d && mkdir -p /usr/local/sbin/ && \
    wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker -O /usr/local/sbin/install-ngxblocker && \
    chmod +x /usr/local/sbin/install-ngxblocker

# Copy content
RUN mkdir -p /usr/local/scripts/ && \
    mkdir -p /var/run/php
ADD /content/scripts/ /usr/local/scripts/
ADD /content/jinja2/ /root/jinja2/
ADD /content/entrypoint.sh /root/entrypoint.sh
RUN chmod 755 /root/entrypoint.sh

# Implement health-check
HEALTHCHECK --retries=3 --interval=5s --timeout=3s \
    CMD /usr/bin/php${PHP_V} /usr/local/scripts/health-check.php

WORKDIR ${NGINX_DOCUMENTROOT}

EXPOSE 80

ENTRYPOINT ["/root/entrypoint.sh"]