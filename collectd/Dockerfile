# DESCRIPTION: install and run collectd with libcurl3-gnutls for nginx plugin
# AUTHOR: aglorei
# COMMENTS:
# This installs and provides the dependency necessary to have collectd poll the
# status ngx_http_stub_status_module.

# Base image
FROM debian:jessie

# Install collectd, include libcurl3-gnutls for nginx plugin
RUN apt-get update && \
  apt-get install -y \
  libcurl3-gnutls \
  collectd \
  python-setuptools && \
  easy_install j2cli && \
  apt-get purge -y --auto-remove && \
  rm -rf /var/lib/apt/lists/*

COPY collectd.conf.j2 /templates/
COPY docker_entrypoint.sh /

ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["collectd", "-f"]
