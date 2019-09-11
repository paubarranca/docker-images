#!/bin/sh

# Create cfg file from template
/usr/bin/j2 /root/jinja2/haproxy.j2  /root/jinja2/yaml/haproxy.yaml > /etc/haproxy/haproxy.cfg

exec /usr/sbin/haproxy -db -f /etc/haproxy/haproxy.cfg