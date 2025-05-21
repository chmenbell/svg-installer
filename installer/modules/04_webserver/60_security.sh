#!/bin/bash
# Versión: 2.0.0
# Aplica medidas de seguridad a Nginx

set -euo pipefail

source installer/core/logging.sh

NGINX_CONF="/etc/nginx/nginx.conf"

log_info "Aplicando medidas de seguridad a Nginx..."

if grep -q "server_tokens off" "$NGINX_CONF"; then
  log_info "server_tokens off ya está configurado en $NGINX_CONF"
else
  sed -i "/http {/a \    server_tokens off;" "$NGINX_CONF"
  log_info "server_tokens off añadido en $NGINX_CONF"
fi

systemctl restart nginx

log_info "Medidas de seguridad aplicadas a Nginx."