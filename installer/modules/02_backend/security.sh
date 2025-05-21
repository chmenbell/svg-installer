#!/bin/bash
# Versión: 2.0.0
# Aplica medidas de seguridad a Django

set -euo pipefail

source installer/core/logging.sh
SETTINGS_FILE="svgviewer/settings.py"

log_info "Aplicando medidas de seguridad a Django..."

if [ -f "$SETTINGS_FILE" ]; then
  sed -i "s/DEBUG = True/DEBUG = False/" "$SETTINGS_FILE"
  sed -i "s/'django.middleware.security.SecurityMiddleware',/'django.middleware.security.SecurityMiddleware',\\n    'django.middleware.clickjacking.XFrameOptionsMiddleware',\\n    'django.middleware.common.CommonMiddleware',/" "$SETTINGS_FILE"
  log_info "Medidas de seguridad aplicadas a Django."
else
  log_error "No se encontró $SETTINGS_FILE para aplicar medidas de seguridad."
  exit 1
fi