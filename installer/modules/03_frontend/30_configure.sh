#!/bin/bash
# Versión: 1.0.0
# Descripción: Configura React

source installer/core/logging.sh
source installer/core/config_manager.sh # Añadir esta línea
source installer/core/error_handling.sh
source installer/core/utils.sh

log_info "Configurando React..."

# Configurar la URL del backend en la aplicación React
if [ -n "$(get_config_value DOMAIN)" ]; then
  sed -i "s/proxy: 'http:\/\/localhost:8000',/proxy: 'https:\/\/$(get_config_value DOMAIN)\/api',/" frontend/package.json # Reemplazar con tu dominio y ruta de la API
else
  handle_error "La variable DOMAIN no está definida en config/settings.conf" 1
fi

log_info "React configurado."