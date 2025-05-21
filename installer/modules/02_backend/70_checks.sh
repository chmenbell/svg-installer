#!/bin/bash
# Versión: 1.0.0
# Descripción: Verifica la instalación y configuración de Django

source installer/core/logging.sh
source installer/core/utils.sh

log_info "Verificando la instalación y configuración de Django..."

# Verificar si Django está instalado
if ! python -c "import django" &> /dev/null; then
  handle_error "Django no está instalado." 1
fi

# Verificar si el proyecto Django svgviewer existe
if [ ! -d "svgviewer" ]; then
  handle_error "El proyecto Django svgviewer no existe." 1
fi

log_info "Django instalado y configurado correctamente."