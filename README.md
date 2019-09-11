Custom Docker Images ![](https://img.shields.io/github/stars/paubarranca/docker-images) ![](https://img.shields.io/github/forks/paubarranca/docker-images) ![](https://img.shields.io/github/release//paubarranca/docker-images)
=============

This repository contains Dockerfiles and different resources to create custom containers images, including the Dockerfiles, scripts, config files... 

All the images are available in Docker Hub at [paubarranca](https://hub.docker.com/?namespace=paubarranca), feel free to use them ;)

Please use a tagged image that works for you as v1, v2... DO NOT USE the latest tag in any of the images!

Haproxy
-------------

The haproxy uses jinja2 and a .yaml configuration file to automate the haproxy configuration, to set it up you have to put specific variables in the haproxy.yaml file and the entrypoint.sh script will create the haproxy.cfg based on these file.

### Docker-compose



    version: '3'
    services:
      haproxy:
        container_name: haproxy
        image: paubarranca/haproxy:v1
        restart: always
        network_mode: host
        volumes:
            - /srv/haproxy/yaml/:/jinja2/yaml
            - /srv/haproxy/certs:/etc/haproxy/certs
        ports:
            - "80:80"
            - "443:44"

![](https://i2.wp.com/blog.ichasco.com/wp-content/uploads/2017/06/compose-1-1.png?resize=453%2C261&ssl=1)

To use your own yaml file, you have to set these volume `- /srv/haproxy/yaml/:/jinja2/yaml`, if you only want to test the haproxy container, comment it `$ - /srv/haproxy/yaml/:/jinja2/yaml`.

If you want to enable HTTPS, remember to put the certificate + CA certificates + key in a single .pem file, located in the path of the docker volume `/srv/haproxy/certs`.


### Jinja2 YAML file

To configure your custom haproxy.yaml file you need to use the variables that i have defined, i will explain what some of them do

    rules:
        dev:
           domains:
               - dev.zobalo.com
            port: 81
            auth:
            tls: 
        prod:
            domains:
                - zobalo.com
            port: 82
            tls: rewrite


    default_site: 'prod'

    auth_users:
            users:
                - test: mypasswd

To implement https traffic in one of the sites the variable `tls` must exist, if you want to rewrite http traffic to https then it must look like this `tls: rewrite`.

For user authentication it must be defined at `users` in the YAML file and add the `auth` in your site.

