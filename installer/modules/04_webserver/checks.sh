#!/bin/bash
# Versión: 1.0.0
# Descripción: Verifica la configuración de Nginx

source installer/core/logging.sh
source installer/core/utils.sh

log_info "Verificando la configuración de Nginx..."

# Verificar si Nginx está instalado
if ! command_exists nginx; then
  handle_error "Nginx no está instalado." 1
fi

# Verificar si el archivo de configuración svgviewer existe
if [ ! -f "/etc/nginx/sites-available/svgviewer" ]; then
  handle_error "El archivo de configuración /etc/nginx/sites-available/svgviewer no existe." 1
fi

# Verificar si el enlace simbólico a svgviewer existe en sites-enabled
if [ ! -L "/etc/nginx/sites-enabled/svgviewer" ]; then
  handle_error "El enlace simbólico a /etc/nginx/sites-available/svgviewer no existe en /etc/nginx/sites-enabled/." 1
fi

log_info "Nginx configurado correctamente."