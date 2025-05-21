#!/bin/bash
# Versión: 2.0.0
# Configura Django

set -euo pipefail

source installer/core/logging.sh
source installer/core/config_manager.sh
source installer/core/error_handling.sh

log_info "Configurando Django..."

SECRET_KEY=$(openssl rand -base64 48)
SETTINGS_FILE="svgviewer/settings.py"

if [ ! -f "$SETTINGS_FILE" ]; then
  handle_error "No se encontró el archivo settings.py en $SETTINGS_FILE" 1
fi

if [ -n "$(get_config_value DOMAIN)" ]; then
  sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \['$(get_config_value DOMAIN)'\]/" "$SETTINGS_FILE"
else
  handle_error "La variable DOMAIN no está definida en config/settings.conf" 1
fi

sed -i "s/SECRET_KEY = .*/SECRET_KEY = '$SECRET_KEY'/" "$SETTINGS_FILE"

log_info "Django configurado de forma segura."