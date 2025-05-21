#!/bin/bash
# Versión: 1.0.0
# Descripción: Aplica medidas de seguridad a React

source installer/core/logging.sh

log_info "Aplicando medidas de seguridad a React..."

# Deshabilitar la generación de mapas de origen en producción
sed -i "s/GENERATE_SOURCEMAP=true/GENERATE_SOURCEMAP=false/" frontend/.env

log_info "Medidas de seguridad aplicadas a React."