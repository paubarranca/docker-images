#!/bin/bash -e

# Nginx config files
j2 /root/jinja2/nginx-conf.j2 > /etc/nginx/nginx.conf
j2 /root/jinja2/nginx-site.j2 > /etc/nginx/sites-enabled/default
j2 /root/jinja2/nginx-remoteip.j2 > /etc/nginx/conf.d/remoteip.conf

# PHP config files
j2 /root/jinja2/php-fpm-conf.j2 > /etc/php/${PHP_V}/fpm/php-fpm.conf
# j2 /root/jinja2/php-extras.j2 > /etc/php/${PHP_V}/nginx/conf.d/25-extras.ini

# Supervisor config file
j2 /root/jinja2/supervisord.j2 > /etc/supervisor/supervisord.conf

/usr/local/sbin/install-ngxblocker
chmod 755 /usr/local/sbin/setup-ngxblocker
chmod 755 /usr/local/sbin/update-ngxblocker
echo '00 22 * * * root /usr/local/sbin/update-ngxblocker > /dev/null' > /etc/cron.d/update-badbots

if [[ "$#" < "1" ]]; then
  exec supervisord -n -c /etc/supervisor/supervisord.conf
else
  exec $@
fi