#!/bin/bash
# Versión: 1.0.0
# Descripción: Prueba la integración entre el frontend y el backend

source installer/core/logging.sh

log_info "Ejecutando prueba de integración frontend-backend..."

# Verificar si la aplicación está accesible
if curl -s https://svgviewer.kaffresh.com | grep -q "SVGViewer"; then # Reemplazar con tu dominio
  log_info "La aplicación está accesible."
else
  log_error "La aplicación no está accesible."
  exit 1
fi

log_info "Prueba de integración frontend-backend completada."