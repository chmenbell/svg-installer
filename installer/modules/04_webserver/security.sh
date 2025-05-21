#!/bin/bash
# Versión: 1.0.0
# Descripción: Aplica medidas de seguridad a Nginx

source installer/core/logging.sh

log_info "Aplicando medidas de seguridad a Nginx..."

# Deshabilitar la visualización de la versión de Nginx
sed -i "s/http {/http {\\n\    server_tokens off;/" /etc/nginx/nginx.conf

# Reiniciar Nginx para aplicar los cambios
systemctl restart nginx

log_info "Medidas de seguridad aplicadas a Nginx."