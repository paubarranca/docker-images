redis
-------------
![](https://img.shields.io/docker/cloud/automated/paubarranca/redis) ![](https://img.shields.io/docker/pulls/paubarranca/redis) ![](https://img.shields.io/docker/cloud/build/paubarranca/redis)

This redis image is based on debian 10 and secured to launch all the processes as user redis and group redis.

![redis](https://www.ks7000.net.ve/wp-content/uploads/2019/08/Redis-logotipo.png)

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