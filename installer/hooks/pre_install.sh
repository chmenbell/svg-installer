#!/bin/bash
# Versión: 1.0.0
# Descripción: Ejecuta comandos antes de la instalación

source installer/core/logging.sh

log_info "Ejecutando comandos pre-instalación..."

# Verificar si el usuario actual tiene permisos de administrador
if [[ $EUID -ne 0 ]]; then
  log_error "Este script debe ser ejecutado como root."
  exit 1
fi

log_info "Comandos pre-instalación completados."