DEBIAN-APACHE-PHP
-------------
![](https://img.shields.io/docker/cloud/automated/paubarranca/debian-apache-php) ![](https://img.shields.io/docker/pulls/paubarranca/debian-apache-php) ![](https://img.shields.io/docker/cloud/build/paubarranca/debian-apache-php)

Lightweight debian-apache image uses an apache server by default and php-fpm 7.3 version

### Docker-compose

    version: '3'
    services:
      apache:
        container_name: apache
        image: paubarranca/debian-apache-php:v7.3
        restart: always
        volumes:
          - /srv/apache/www:/var/www/httpdocs
        ports:
          - "80:80"

![docker-compose](https://user-images.githubusercontent.com/49031072/64709154-14d2b380-d4b6-11e9-8613-ee343a9e4cce.png)