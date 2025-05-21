#!/bin/bash
# Versión: 1.0.0
# Descripción: Prueba el estado de los servicios

source installer/core/logging.sh

log_info "Ejecutando prueba de validación del estado de los servicios..."

# Verificar si Nginx está en ejecución
if systemctl is-active nginx; then
  log_info "Nginx está en ejecución."
else
  log_error "Nginx no está en ejecución."
  exit 1
fi

# Verificar si PostgreSQL está en ejecución
if systemctl is-active postgresql; then
  log_info "PostgreSQL está en ejecución."
else
  log_error "PostgreSQL no está en ejecución."
  exit 1
fi

log_info "Prueba de validación del estado de los servicios completada."