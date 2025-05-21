#!/bin/bash
# Versión: 1.0.0
# Descripción: Aplica medidas de seguridad a los requisitos previos del sistema

source installer/core/logging.sh

log_info "Aplicando medidas de seguridad a los requisitos previos..."

# Actualizar el sistema
apt-get update
apt-get upgrade -y

log_info "Medidas de seguridad aplicadas a los requisitos previos."