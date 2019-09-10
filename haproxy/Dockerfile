FROM alpine:3.10

MAINTAINER Pau Barranca <paubarrancamon@gmail.com>
LABEL name="paubarranca/haproxy:latest"

ENV HAPROXY_USER=haproxy
ENV HAPROXY_GROUP=haproxy

# Install dependencies
RUN apk update && \
    apk --no-cache add tini haproxy py-pip build-base PyYAML j2 j2cli python python-dev python-resources \
    rm -rf /etc/haproxy/haproxy.cfg \
    rm -rf /var/cache/apk/* \
    rm -rf /var/lib/apt/lists/* \

# Copy jinja template
COPY /content/jinja2/ /jinja2/

# Copy entrypoint.sh
COPY /content/entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

EXPOSE 80 443

ENTRYPOINT [ "/root/entrypoint.sh" ]