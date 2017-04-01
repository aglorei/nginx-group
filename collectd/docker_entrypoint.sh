#!/bin/bash -e
j2 /templates/collectd.conf.j2 > /etc/collectd/collectd.conf
cp /usr/share/collectd/types.db /var/lib/collectd/types.db
exec "$@"
