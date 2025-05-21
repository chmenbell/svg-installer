#!/bin/bash
# Versión: 1.1.0
# Descripción: Configura Nginx y genera un certificado SSL autofirmado

source installer/core/logging.sh
source installer/core/config_manager.sh
source installer/core/error_handling.sh
source installer/core/utils.sh

log_info "Configurando Nginx y generando certificado SSL autofirmado..."

DOMAIN="$(get_config_value DOMAIN)"

# Generar certificado SSL autofirmado
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out /etc/ssl/certs/nginx-selfsigned.crt \
  -subj "/CN=$DOMAIN"

# Eliminar la configuración por defecto de Nginx si existe
if [ -f /etc/nginx/sites-enabled/default ]; then
  rm /etc/nginx/sites-enabled/default
fi

# Copiar la plantilla de configuración de Nginx
log_info "Copiando la plantilla de configuración de Nginx..."
cp installer/templates/nginx/svgviewer.conf.template /etc/nginx/sites-available/svgviewer

# Reemplazar el dominio en el archivo de configuración
sed -i "s/your_domain.com/$DOMAIN/g" /etc/nginx/sites-available/svgviewer

# Crear un enlace simbólico solo si no existe
if [ ! -L /etc/nginx/sites-enabled/svgviewer ]; then
  ln -s /etc/nginx/sites-available/svgviewer /etc/nginx/sites-enabled/svgviewer
fi

# Reiniciar Nginx para aplicar los cambios
systemctl restart nginx || handle_error "No se pudo reiniciar nginx" 1

log_info "Nginx configurado y certificado SSL autofirmado generado."