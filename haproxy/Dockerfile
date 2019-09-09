FROM alpine:3.10

MAINTAINER Pau Barranca <paubarrancamon@gmail.com>
LABEL name="paubarranca/haproxy:latest"

# Install dependencies
RUN apk update && \
    apk --no-cache add tini haproxy py-pip build-base python-dev ca-certificates

# Copy Modified config
COPY haproxy.cfg /etc/haproxy/haproxy.cfg

EXPOSE 80 443

CMD ["-f", "/etc/haproxy/haproxy.cfg"]