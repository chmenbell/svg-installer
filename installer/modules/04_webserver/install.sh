#!/bin/bash
# Versión: 2.0.0
# Configura Nginx y genera un certificado SSL autofirmado

source installer/core/logging.sh
source installer/core/config_manager.sh
source installer/core/error_handling.sh
source installer/core/utils.sh

DOMAIN="$(get_config_value DOMAIN)"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out /etc/ssl/certs/nginx-selfsigned.crt \
  -subj "/CN=$DOMAIN"

[ -L /etc/nginx/sites-enabled/svgviewer ] && rm /etc/nginx/sites-enabled/svgviewer
[ -f /etc/nginx/sites-enabled/default ] && rm /etc/nginx/sites-enabled/default

cp installer/templates/nginx/svgviewer.conf.template /etc/nginx/sites-available/svgviewer
sed -i "s/your_domain.com/$DOMAIN/g" /etc/nginx/sites-available/svgviewer

ln -s /etc/nginx/sites-available/svgviewer /etc/nginx/sites-enabled/svgviewer

systemctl restart nginx || handle_error "No se pudo reiniciar nginx" 1

log_info "Nginx configurado y certificado SSL autofirmado generado."