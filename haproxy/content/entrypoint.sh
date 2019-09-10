#!/bin/sh

# Create cfg file from template
/usr/bin/j2 /jinja2/haproxy.j2  /jinja2/haproxy.yaml > /etc/haproxy/haproxy.cfg

exec /usr/sbin/haproxy -db -f /etc/haproxy/haproxy.cfg