#!/bin/bash
# Versión: 1.0.0
# Descripción: Instala los requisitos previos del sistema
source installer/core/logging.sh

log_info "Actualizando el sistema..."
apt-get update

log_info "Instalando dependencias..."
apt-get install -y \
  software-properties-common \
  python3-pip \
  nginx

log_info "Requisitos previos instalados."