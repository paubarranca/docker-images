FROM debian:10.2-slim

MAINTAINER Pau Barranca <paubarrancamon@gmail.com>
LABEL name="paubarranca/redis:latest"

ENV DEBIAN_FRONTEND=noninteractive

ENV REDIS_V=5.0.3 \
    REDIS_USER=redis \
    REDIS_GROUP=redis

ENV REDIS_DATA_DIR=/var/lib/redis/ \
    REDIS_LOG_DIR=/var/log/redis/ \
    REDIS_SOCKET_DIR=/var/run/redis/

RUN apt-get update \
    && apt-get install -y redis-server \
    && sed 's/^logfile /# logfile /' -i /etc/redis/redis.conf \
    && sed 's/^daemonize yes/daemonize no/' -i /etc/redis/redis.conf \
    && sed 's/^protected-mode yes/protected-mode no/' -i /etc/redis/redis.conf \
    && sed 's/^# unixsocket /unixsocket /' -i /etc/redis/redis.conf \
    && sed 's/^# unixsocketperm 700/unixsocketperm 777/' -i /etc/redis/redis.conf \
    && rm -rf /var/lib/apt/lists/* \

    # Enforce redis to send logs to stdout
    && ln -sf /dev/stdout ${REDIS_LOG_DIR}access.log \
    && ln -sf /dev/stdout ${REDIS_LOG_DIR}error.log

# Secure directories with redis user
RUN chmod -R 0755 ${REDIS_LOG_DIR} \
    && chown -R ${REDIS_USER}:${REDIS_GROUP} ${REDIS_LOG_DIR} \
    && chmod -R 0755 ${REDIS_DATA_DIR} \
    && chown -R ${REDIS_USER}:${REDIS_GROUP} ${REDIS_DATA_DIR} \
    && mkdir -p ${REDIS_SOCKET_DIR} \
    && chmod -R 0755 ${REDIS_SOCKET_DIR} \
    && chown -R ${REDIS_USER}:${REDIS_GROUP} ${REDIS_SOCKET_DIR}

COPY /content/entrypoint.sh /root/entrypoint.sh
RUN chmod 755 /root/entrypoint.sh

EXPOSE 6379
ENTRYPOINT ["/root/entrypoint.sh"]