#!/bin/bash
# Versión: 1.1.0
# Descripción: Instala los requisitos previos del sistema
source installer/core/logging.sh
source installer/core/error_handling.sh

log_info "Actualizando el sistema..."
apt-get update || handle_error "Fallo al actualizar el sistema" 1

log_info "Instalando dependencias..."
apt-get install -y \
  software-properties-common \
  python3-pip \
  nginx || handle_error "Fallo instalando dependencias" 1

log_info "Requisitos previos instalados."