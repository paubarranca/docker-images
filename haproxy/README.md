haproxy
-------------
![](https://img.shields.io/docker/cloud/automated/paubarranca/haproxy) ![](https://img.shields.io/docker/pulls/paubarranca/haproxy) ![](https://img.shields.io/docker/cloud/build/paubarranca/haproxy)

The haproxy images is based on alpine 3 and uses jinja2 and a YAML configuration file to automate the haproxy configuration, to set it up you have to put specific variables in the haproxy.yaml file and the entrypoint.sh script will create the haproxy.cfg based on these file.

![haproxy](https://www.ochobitshacenunbyte.com/wp-content/uploads/2019/12/logo-haproxy.png)

### Docker-compose
```yaml
    version: '3'
    services:
      haproxy:
        container_name: haproxy
        image: paubarranca/haproxy:v1
        restart: always
        volumes:
            - /srv/haproxy/yaml/:/root/jinja2/yaml
            - /srv/haproxy/certs:/etc/haproxy/certs
        ports:
            - "80:80"
            - "443:44"
```

![docker-compose](https://user-images.githubusercontent.com/49031072/64709154-14d2b380-d4b6-11e9-8613-ee343a9e4cce.png)

To use your own YAML file, you have to set these volume `- /srv/haproxy/yaml/:/root/jinja2/yaml`, to run the container with the default YAML comment it `# - /srv/haproxy/yaml/:/root/jinja2/yaml`.

If you want to enable HTTPS, remember to put the certificate + CA certificates + key in a single .pem file, located in the path of the docker volume `/srv/haproxy/certs`.


### Jinja2 YAML file

To configure your custom haproxy.yaml file you need to use the variables that i have defined:

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