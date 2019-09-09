#!/bin/sh

# Create haproxy user and grant ownership
groupadd --system ${HAPROXY_GROUP}
useradd --system --gid ${HAPROXY_GROUP} ${HAPROXY_USER}
mkdir --parents /var/lib/${HAPROXY_USER}
chown -R ${HAPROXY_USER}:${HAPROXY_GROUP} /var/lib/${HAPROXY_USER}

exec /usr/sbin/haproxy -db -f /etc/haproxy/haproxy.cfg