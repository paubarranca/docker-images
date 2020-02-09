#!/bin/bash -e

# Apache config files
j2 /root/jinja2/apache-conf.j2 > /etc/apache2/apache2.conf
j2 /root/jinja2/apache-mpm.j2 > /etc/apache2/mods-enabled/mpm_event.conf
j2 /root/jinja2/apache-site.j2 > /etc/apache2/sites-enabled/000-default.conf
j2 /root/jinja2/apache-php-fpm-conf.j2 > /etc/apache2/conf-enabled/php${PHP_V}-fpm.conf
j2 /root/jinja2/apache-remoteip.j2 > /etc/apache2/mods-enabled/remoteip.conf

# PHP config files
j2 /root/jinja2/php-fpm-conf.j2 > /etc/php/${PHP_V}/fpm/php-fpm.conf
j2 /root/jinja2/php-extras.j2 > /etc/php/${PHP_V}/apache2/conf.d/25-extras.ini

# Supervisor config file
j2 /root/jinja2/supervisord.j2 > /etc/supervisor/supervisord.conf

if [[ "$#" < "1" ]]; then
  exec supervisord -n -c /etc/supervisor/supervisord.conf
else
  exec $@
fi