# Nginx and Telegraf Cluster

This repository configures an HTTPS reverse proxy with a server sidecar for collecting metrics.

- Nginx 1.11.10-alpine service
  - See [Nginx documentation on HTTPS configuration and optimization](http://nginx.org/en/docs/http/configuring_https_servers.html)
  - The [`ngx_http_stub_status_module`](ngx_http_stub_status_module) is enabled at `http://<hostname>:<port>/nginx_status` for basic status data used in metrics reporting
- Telegraf 1.2.1-alpine service
  - See [InfluxData's documentation on the Nginx plugin for Nginx](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/nginx)
  - Outputs to InfluxDB to the default retention policy on a database "nginx"

#### Requirements
- SSL certificate on the proxy host for HTTPS
- InfluxDB server for recording metrics
  - Optional: retention policies and continuous queries created on a database "nginx"
- Syslog server for logging

#### Quick Start:
Configure environment variables, or a `.env`:
| Variable | Description |
| ------------- | ------------- |
| `AGENT_HOSTNAME` | Name used in tag values for "host" in InfluxDB database |
| `AGENT_INTERVAL` | Data collection interval for Telegraf Nginx plugin |
| `INFLUXDB_HOST` | InfluxDB host and transport protocol (e.g., `http://10.0.0.1`) |
| `INFLUXDB_PORT` | InfluxDB port that server is listening on (e.g., `8086`) |
| `SYSLOG_ADDRESS` | Syslog host, transport protocol, and port (e.g., `tcp://10.0.0.2:514`) |
| `SSL_CERTIFICATE` | Path to SSL certificate (e.g., `/etc/ssl/certs/server.crt`) |
| `SSL_CERTIFICATE_KEY` | Path to private key (e.g., `/etc/ssl/private/server.key`) |
| `SSL_TRUSTED_CERTIFICATE` | Path to trusted CA certificates PEM format (e.g., `/etc/ssl/private/ca-certs.pem`) |
| `DH_PARAMS` | Path to DH parameters for DHE ciphers (e.g., `/etc/ssl/certs/dhparam.pem`) |

To build and start containers:

```
docker-compose up -d
```

