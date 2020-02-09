debian-apache-php
-------------
![](https://img.shields.io/docker/cloud/automated/paubarranca/debian-apache-php) ![](https://img.shields.io/docker/pulls/paubarranca/debian-apache-php) ![](https://img.shields.io/docker/cloud/build/paubarranca/debian-apache-php)

The debian-apache image is based on debian 10 and uses an apache server, some useful apache modules, php-fpm version 7.4, and uses jinja to configure some parameters via environment variables [(see the example)](#docker-compose-with-env-variables).

This docker image is meant to be used using only http, so it doesn't have any of the https related modules and features, be sure to architect the infraestructure with a tls-handler proxy between the client and the container.

![apache](https://zdnet4.cbsistatic.com/hub/i/2019/04/03/9b318728-bf96-4c85-9130-0655cc6a31f9/apache-web-server-logo.png)

### Fully explained references

* [CORS(Acces Control Origin Headers)](https://developer.mozilla.org/es/docs/Web/HTTP/Access_control_CORS)
* [KeepAlive](https://www.svennd.be/keepalive-on-or-off-apache-tuning/)
* [CSP(Content Security Policy)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)
* [Remote Ip Module](https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_72/rzaie/rzaiemod_remoteip.htm)
* [Post and Upload Max Size](https://stackoverflow.com/questions/23686505/php-post-max-size-vs-upload-max-filesize-what-is-the-difference)
* [PHP Security(Disable functions)](https://www.cyberciti.biz/faq/linux-unix-apache-lighttpd-phpini-disable-functions/)

### Basic docker-compose

```yaml

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
```

### Docker-compose with env variables

```yaml
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
    env:
      # You can modfiy the jinja variables to set up personalized values in here, boolean variables use (true|false)- THE CONFIG WILL NOT WORK WITH THESECOMMENTS
        # Allows restricted resources on a web page to be requested from another domain outside the domain from which the resource originated
      - APACHE_ENABLE_CORS="false"
      # Optional extra domains whick can access the resources (ex: https://yourexample.com)
      - APACHE_CORS_ORIGIN=""
      # Maximum alive sessions that will remain alive for an x amount of time
      - KEEPALIVE_MAX_REQUESTS="3500"
      # Time that these sessions will remain open if they are not doing requests
      - KEEPALIVE_TIMEOUT="600"
      # Number of servers that apache will launch in start
      - APACHE_START_SERVERS="2"
      # Maximum number of child processes that will be launched to serve requests 
      - APACHE_MAX_REQUEST_WORKERS="256"
      # Document root path from which apache will serve content
      - APACHE_DOCUMENTROOT="/var/www/httpdocs"
      # Bot Blacklisting (Source: https://github.com/mitchellkrogza/apache-ultimate-bad-bot-blocker/)
      - APACHE_ENABLE_BADBOTS="true"
      # Enables Content Security Policy that allows you yo choose which dynamics rsources are allowed to load
      - APACHE_ENABLE_CSP="false"
      # Set the CSP headers
      - APACHE_CSP_HEADER="your_headers"
      # Set a default range from which a Proxy will communicate with apache
      - APACHE_REMOTEIP_PROXY_RANGE="192.168.45.0/32"
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