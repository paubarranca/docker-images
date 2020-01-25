redis
-------------
![](https://img.shields.io/docker/cloud/automated/paubarranca/debian-apache-php) ![](https://img.shields.io/docker/pulls/paubarranca/debian-apache-php) ![](https://img.shields.io/docker/cloud/build/paubarranca/debian-apache-php)

This redis image is based on debian 10 and secured to launch all the processes as user redis and group redis.

### Docker-compose
```yaml
version: '3'
services:
  redis:
    container_name: redis
    image: paubarranca/redis:latest
    restart: always
    ports:
        - "6379:6379"
```

![docker-compose](https://user-images.githubusercontent.com/49031072/64709154-14d2b380-d4b6-11e9-8613-ee343a9e4cce.png)