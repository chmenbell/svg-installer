#!/bin/bash
# Versión: 2.0.0
# Configura copias de seguridad de Nginx

set -euo pipefail

source installer/core/logging.sh

BACKUP_DIR="/var/backups/svgviewer"
CONFIG_FILE="/etc/nginx/sites-available/svgviewer"
BACKUP_FILE="$BACKUP_DIR/nginx_$(date +%Y%m%d_%H%M%S).conf"

mkdir -p "$BACKUP_DIR"
chmod 700 "$BACKUP_DIR"

if [ -f "$CONFIG_FILE" ]; then
  cp "$CONFIG_FILE" "$BACKUP_FILE"
  chmod 600 "$BACKUP_FILE"
  log_info "Copia de seguridad de Nginx realizada en $BACKUP_FILE."
else
  log_error "No se encontró el archivo de configuración de Nginx en $CONFIG_FILE."
  exit 1
fi