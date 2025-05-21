#!/bin/bash
# Versión: 2.0.0
# Construye la aplicación React

set -euo pipefail

source installer/core/logging.sh

FRONTEND_DIR="/absolute/path/to/frontend" # <--- AJUSTA ESTA RUTA

if [ ! -d "$FRONTEND_DIR" ]; then
  log_error "El directorio del frontend no existe: $FRONTEND_DIR"
  exit 1
fi

cd "$FRONTEND_DIR"

log_info "Instalando dependencias de frontend..."
npm install

log_info "Construyendo la aplicación React..."
npm run build

log_info "Aplicación React construida exitosamente."