#!/bin/sh -e
j2 /templates/collectd.conf.j2 > /etc/collectd/collectd.conf
exec "$@"
