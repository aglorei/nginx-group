# DESCRIPTION: configure and run nginx 1.11.10
# AUTHOR: aglorei
# COMMENTS:
# This uses ngx_http_stub_status_module to send collectd usage information, and
# provides an endpoint for a grafana dashboard. It requires an SSL certificate
# from a provider.
# USAGE:
# Build nginx image
# docker build -t turtle-nginx
#
# Run nginx
# docker run --name turtle-nginx \
#   -e GRAFANA_ENDPOINT=<grafana_server_address> \
#   -e MONITORING_ENDPOINT=35.162.137.87 \
#   -v </path/to/ssl/certificate.pem>:/etc/ssl/certs/ssl-cert.pem:ro \
#   -v </path/to/ssl/private/key.pem:/etc/ssl/private/ssl-cert.pem:ro \
#   -v </path/to/dhparam.pem>:/etc/ssl/certs/dhparam.pem:ro \
#   -p 80:80 -p 443:443 -d --restart=always turtle-nginx:latest

# Base Image
FROM nginx:1.11.10

# Install j2cli
RUN apt-get update && \
  apt-get install -y python-setuptools && \
  easy_install j2cli && \
  apt-get purge -y --auto-remove && \
  rm -rf /var/lib/apt/lists/*

# Copy over templates
COPY aglorei_nginx.conf.j2 /templates/
COPY docker_entrypoint.sh /

# Entrypoint and CMD
ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
