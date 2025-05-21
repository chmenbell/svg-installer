#!/bin/bash
# Versión: 1.0.0
# Descripción: Configura Django

source installer/core/logging.sh
source installer/core/config_manager.sh # Añadir esta línea
source installer/core/error_handling.sh
source installer/core/utils.sh

log_info "Configurando Django..."

# Generar una clave secreta aleatoria
SECRET_KEY=$(openssl rand -base64 32)

# Reemplazar el dominio en el archivo settings.py
if [ -n "$(get_config_value DOMAIN)" ]; then
  sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \['$(get_config_value DOMAIN)'\]/" svgviewer/settings.py # Reemplazar con tu dominio
else
  handle_error "La variable DOMAIN no está definida en config/settings.conf" 1
fi

log_info "Django configurado."