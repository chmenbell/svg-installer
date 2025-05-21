#!/bin/bash
# Versión: 1.0.0
# Descripción: Configura copias de seguridad de Nginx

source installer/core/logging.sh

log_info "Configurando copias de seguridad de Nginx..."

# Definir variables
BACKUP_DIR="/var/backups/svgviewer"
CONFIG_FILE="/etc/nginx/sites-available/svgviewer"
BACKUP_FILE="$BACKUP_DIR/nginx_$(date +%Y%m%d_%H%M%S).conf"

# Crear el directorio de copias de seguridad si no existe
mkdir -p $BACKUP_DIR

# Copiar el archivo de configuración
cp "$CONFIG_FILE" "$BACKUP_FILE"

log_info "Copia de seguridad de Nginx completada."