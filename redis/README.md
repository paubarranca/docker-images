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