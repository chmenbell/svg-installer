#!/bin/bash
# Versión: 2.0.0
# Verifica la configuración de Nginx

set -euo pipefail

source installer/core/logging.sh
source installer/core/utils.sh
source installer/core/error_handling.sh

log_info "Verificando la configuración de Nginx..."

if ! command_exists nginx; then
  handle_error "Nginx no está instalado." 1
fi

if [ ! -f "/etc/nginx/sites-available/svgviewer" ]; then
  handle_error "El archivo de configuración /etc/nginx/sites-available/svgviewer no existe." 1
fi

if [ ! -L "/etc/nginx/sites-enabled/svgviewer" ]; then
  handle_error "El enlace simbólico a /etc/nginx/sites-available/svgviewer no existe en /etc/nginx/sites-enabled/." 1
fi

log_info "Nginx configurado correctamente."