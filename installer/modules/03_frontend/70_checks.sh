#!/bin/bash
# Versión: 1.0.0
# Descripción: Verifica la instalación y configuración de React

source installer/core/logging.sh
source installer/core/utils.sh

log_info "Verificando la instalación y configuración de React..."

# Verificar si Node.js está instalado
if ! command_exists node; then
  handle_error "Node.js no está instalado." 1
fi

# Verificar si npm está instalado
if ! command_exists npm; then
  handle_error "npm no está instalado." 1
fi

# Verificar si la aplicación React frontend existe
if [ ! -d "frontend" ]; then
  handle_error "La aplicación React frontend no existe." 1
fi

log_info "React instalado y configurado correctamente."