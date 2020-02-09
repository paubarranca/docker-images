debian-nginx-php
-------------
![](https://img.shields.io/docker/cloud/automated/paubarranca/debian-nginx-php) ![](https://img.shields.io/docker/pulls/paubarranca/debian-nginx-php) ![](https://img.shields.io/docker/cloud/build/paubarranca/debian-nginx-php)

The debian-nginx image is based on debian 10 and uses an nginx server, some useful nginx modules, php-fpm version 7.4, and uses jinja to configure some parameters via environment variables [(see the example)](#docker-compose-with-env-variables).

This docker image is meant to be used using only http, so it doesn't have any of the https related modules and features, be sure to architect the infraestructure with a tls-handler proxy between the client and the container.

![nginx](https://www.nginx.com/wp-content/uploads/2018/08/NGINX-logo-rgb-large.png)

### Fully explained references

* [Post and Upload Max Size](https://stackoverflow.com/questions/23686505/php-post-max-size-vs-upload-max-filesize-what-is-the-difference)
* [PHP Security(Disable functions)](https://www.cyberciti.biz/faq/linux-unix-nginx-lighttpd-phpini-disable-functions/)

### Basic docker-compose

```yaml

version: '3'
services:
  nginx:
    container_name: nginx
    image: paubarranca/debian-nginx-php:v7.4
    restart: always
    volumes:
      - /srv/nginx/www:/var/www/httpdocs
    ports:
      - "80:80"
```

### Docker-compose with env variables

```yaml
version: '3'
services:
  nginx:
    container_name: nginx
    image: paubarranca/debian-nginx-php:v7.4
    restart: always
    volumes:
      - /srv/nginx/www:/var/www/httpdocs
    ports:
      - "80:80"
    env:
      # You can modfiy the jinja variables to set up personalized values in here, boolean variables use (true|false)- THE CONFIG WILL NOT WORK WITH THESECOMMENTS
      # Allows restricted resources on a web page to be requested from another domain outside the domain from which the resource originated

      # Maximum amount of memory that a single script is allowed to allocate
      - PHP_MEM_LIMIT="128M"
      - PHP_POST_MAX_SIZE="240M"
      - PHP_UPLOAD_MAX_FILESIZE="240M"
      - PHP_MAX_FILE_UPLOADS="20
      # Show PHP errors or not
      - PHP_DISPLAY_ERRORS="true"
      # Stdout for PHP errors
      - PHP_ERROR_LOG_PATH="/dev/stdout"
      # Max execution time for a PHP script
      - PHP_MAX_EXECUTION_TIME="60"
      # Disallow some functions from the PHP code to be executed
      - PHP_SEC_DISABLE_FUNCTIONS="false"
```


![docker-compose](https://user-images.githubusercontent.com/49031072/64709154-14d2b380-d4b6-11e9-8613-ee343a9e4cce.png)