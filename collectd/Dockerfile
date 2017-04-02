# DESCRIPTION: install and run collectd with nginx, network packages
# AUTHOR: aglorei
# COMMENTS:
# Install collectd in debian base image
# USAGE:
# Build collectd image
# docker build -t collectd-docker
#
# Run collectd
# docker run -d --name=collectd \
# -v /path/to/collectd.conf:/etc/collectd/collectd.conf:ro \
# --volumes-from persistent-storage
# collectd-docker

FROM alpine:3.5

RUN apk add --update \
  collectd \
  # RRDtool plugin writes values to RRD-files
  collectd-rrdtool \
  librrd \
  # Network plugin sends values to other instances and receive values from from
  # other instances
  collectd-network \
  libgcrypt \
	# NGINX plugin collects the number of requests handled since startup and the
	# number of current connections by connection state
  collectd-nginx \
  libcurl \
  # py-pip for j2cli
  py-pip \
  && pip install pip j2cli --upgrade \
  # cleanup
  && rm -rf /var/cache/apk/*

COPY collectd.conf.j2 /templates/
COPY docker_entrypoint.sh /

ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["collectd", "-f"]
