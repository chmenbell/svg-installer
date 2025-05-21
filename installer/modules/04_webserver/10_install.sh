#!/bin/bash
# Versión: 2.0.0
# Configura Nginx y genera un certificado SSL autofirmado

source installer/core/logging.sh
source installer/core/config_manager.sh
source installer/core/error_handling.sh
source installer/core/utils.sh

log_info "Iniciando la instalación y configuración de Nginx."

# Instalar Nginx
log_info "Instalando Nginx usando $PKG_MANAGER..."
if [ "$PKG_MANAGER" == "apt-get" ]; then
  apt-get update -y || handle_error "Fallo al actualizar los repositorios con apt-get."
  apt-get install -y nginx || handle_error "Fallo al instalar Nginx con apt-get."
elif [ "$PKG_MANAGER" == "dnf" ] || [ "$PKG_MANAGER" == "yum" ]; then
  "$PKG_MANAGER" install -y nginx || handle_error "Fallo al instalar Nginx con $PKG_MANAGER."
elif [ "$PKG_MANAGER" == "zypper" ]; then
  zypper install -y nginx || handle_error "Fallo al instalar Nginx con zypper."
else
  handle_error "Gestor de paquetes $PKG_MANAGER no soportado para la instalación de Nginx."
fi
log_info "Nginx instalado correctamente."

systemctl enable nginx || log_warning "No se pudo habilitar Nginx para el inicio en el arranque."
log_info "Nginx habilitado para el inicio en el arranque."

DOMAIN="$(get_config_value DOMAIN)"

log_info "Generando certificado SSL autofirmado para $DOMAIN..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out /etc/ssl/certs/nginx-selfsigned.crt \
  -subj "/CN=$DOMAIN"

[ -L /etc/nginx/sites-enabled/svgviewer ] && rm /etc/nginx/sites-enabled/svgviewer
[ -f /etc/nginx/sites-enabled/default ] && rm /etc/nginx/sites-enabled/default

cp installer/templates/nginx/svgviewer.conf.template /etc/nginx/sites-available/svgviewer
log_info "Plantilla de configuración de Nginx copiada a /etc/nginx/sites-available/svgviewer."

log_info "Reemplazando your_domain.com con $DOMAIN en la configuración de Nginx."
sed -i "s/your_domain.com/$DOMAIN/g" /etc/nginx/sites-available/svgviewer

INSTALL_ROOT_DIR=$(pwd)
ESCAPED_INSTALL_ROOT_DIR=$(printf '%s\n' "$INSTALL_ROOT_DIR" | sed 's:[][\/.^$*]:\\&:g')
log_info "Reemplazando INSTALL_PATH_PLACEHOLDER con $ESCAPED_INSTALL_ROOT_DIR en la configuración de Nginx."
sed -i "s/INSTALL_PATH_PLACEHOLDER/$ESCAPED_INSTALL_ROOT_DIR/g" /etc/nginx/sites-available/svgviewer

log_info "Creando enlace simbólico para la configuración de Nginx."
ln -s /etc/nginx/sites-available/svgviewer /etc/nginx/sites-enabled/svgviewer

log_info "Reiniciando Nginx..."
systemctl restart nginx || handle_error "No se pudo reiniciar nginx" 1

log_info "Nginx configurado, certificado SSL autofirmado generado y servicio reiniciado."