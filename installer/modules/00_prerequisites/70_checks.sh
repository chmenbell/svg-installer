#!/bin/bash
# Versión: 1.0.0
# Descripción: Verifica los requisitos previos del sistema

source installer/core/logging.sh
source installer/core/utils.sh

log_info "Verificando requisitos previos..."

# Verificar si software-properties-common está instalado
if ! dpkg -s software-properties-common >/dev/null 2>&1; then
  handle_error "software-properties-common no está instalado." 1
fi

# Verificar si python3-pip está instalado
if ! command_exists pip3; then
  handle_error "python3-pip no está instalado." 1
fi

# Verificar si Nginx está instalado
if ! command_exists nginx; then
  handle_error "Nginx no está instalado." 1
fi

log_info "Todos los requisitos previos están instalados."