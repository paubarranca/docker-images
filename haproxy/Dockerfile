FROM alpine:3.10

MAINTAINER Pau Barranca <paubarrancamon@gmail.com>
LABEL name="paubarranca/haproxy:latest"

RUN apk update && \
    apk --no-cache add tini haproxy py-pip build-base python-dev ca-certificates

EXPOSE 80 443

