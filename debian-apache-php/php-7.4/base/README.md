Debian-apache-php
-------------
![](https://img.shields.io/docker/cloud/automated/paubarranca/debian-apache-php) ![](https://img.shields.io/docker/pulls/paubarranca/debian-apache-php) ![](https://img.shields.io/docker/cloud/build/paubarranca/debian-apache-php)

The debian-apache image uses an apache server by default, php-fpm 7.4 version and bot blacklisting

### Docker-compose

    version: '3'
    services:
      apache:
        container_name: apache
        image: paubarranca/debian-apache-php:v7.4-slim
        restart: always
        volumes:
          - /srv/apache/www:/var/www/httpdocs
        ports:
          - "80:80"

![docker-compose](https://user-images.githubusercontent.com/49031072/64709154-14d2b380-d4b6-11e9-8613-ee343a9e4cce.png)