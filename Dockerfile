FROM nginx:1.11.10

# install j2cli
RUN apt-get update && \
  apt-get install -y python-setuptools && \
  easy_install j2cli && \
  apt-get purge -y --auto-remove && \
  rm -rf /var/lib/apt/lists/*

# copy over templates
COPY aglorei_nginx.conf.j2 /templates/
COPY docker_entrypoint.sh /

ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
