#!/bin/bash
# Versión: 1.0.0
# Descripción: Configura Nginx y genera un certificado SSL autofirmado

source installer/core/logging.sh
source installer/core/config_manager.sh # Añadir esta línea
source installer/core/error_handling.sh
source installer/core/utils.sh

log_info "Configurando Nginx y generando certificado SSL autofirmado..."

# Definir variables
DOMAIN="$(get_config_value DOMAIN)" # Reemplazar con tu dominio

# Generar certificado SSL autofirmado
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/CN=$DOMAIN"

# Eliminar la configuración por defecto
if [ -f /etc/nginx/sites-enabled/default ]; then
  rm /etc/nginx/sites-enabled/default
fi

# Copiar la plantilla de configuración de Nginx
log_info "Copiando la plantilla de configuración de Nginx..."
cp installer/templates/nginx/svgviewer.conf.template /etc/nginx/sites-available/svgviewer

# Eliminar el directorio del proyecto Django si existe
rm -rf svgviewer

# Crear el entorno virtual
log_info "Creando el entorno virtual..."

# Reemplazar el dominio en el archivo de configuración
sed -i "s/your_domain.com/$DOMAIN/g" /etc/nginx/sites-available/svgviewer

# Crear un enlace simbólico al archivo de configuración en sites-enabled
if [ ! -L /etc/nginx/sites-enabled/svgviewer ]; then
  ln -s /etc/nginx/sites-available/svgviewer /etc/nginx/sites-enabled/svgviewer
fi

if [ ! -L /etc/nginx/sites-enabled/svgviewer ]; then
  ln -s /etc/nginx/sites-available/svgviewer /etc/nginx/sites-enabled/svgviewer
fi


# Crear un enlace simbólico al archivo de configuración en sites-enabled
ln -s /etc/nginx/sites-available/svgviewer /etc/nginx/sites-enabled/

# Eliminar la configuración por defecto
rm /etc/nginx/sites-enabled/default

# Reiniciar Nginx
systemctl restart nginx

log_info "Nginx configurado y certificado SSL autofirmado generado."