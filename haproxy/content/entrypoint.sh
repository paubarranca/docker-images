#!/bin/sh

# Create cfg file from template
j2 /jinja2/haproxy.j2  /jinja2/haproxy.yaml > /etc/haproxy/haproxy.cfg

exec /usr/sbin/haproxy -db -f /etc/haproxy/haproxy.cfg