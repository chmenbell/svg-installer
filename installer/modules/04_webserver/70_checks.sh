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

log_info "Validando la sintaxis de la configuración de Nginx..."
if ! nginx -t; then
  handle_error "La validación de la configuración de Nginx (nginx -t) falló." 1
fi
log_info "Sintaxis de configuración de Nginx OK."

log_info "Verificando el estado del servicio Nginx..."
if ! systemctl is-active --quiet nginx; then
  handle_error "El servicio Nginx no está activo." 1
fi
log_info "Servicio Nginx está activo."

log_info "Verificaciones de Nginx completadas exitosamente."