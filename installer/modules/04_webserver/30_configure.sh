#!/bin/bash
# Versión: 1.0.0
# Descripción: Configura Nginx

source installer/core/logging.sh

log_info "Configurando Nginx..."

# Configurar el tamaño máximo de los archivos que se pueden subir al servidor
sed -i "s/http {/http {\\n    client_max_body_size 10M;/" /etc/nginx/nginx.conf

# Reiniciar Nginx para aplicar los cambios
systemctl restart nginx

log_info "Nginx configurado."