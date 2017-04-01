#!/bin/bash -e
j2 /templates/aglorei_nginx.conf.j2 > /etc/nginx/nginx.conf
exec "$@"
