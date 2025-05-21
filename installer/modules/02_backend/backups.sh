#!/bin/bash
# Versión: 1.0.0
# Descripción: Configura copias de seguridad del backend de Django

source installer/core/logging.sh

log_info "Configurando copias de seguridad del backend de Django..."

# Definir variables
BACKUP_DIR="/var/backups/svgviewer"
SETTINGS_FILE="svgviewer/settings.py"
BACKUP_FILE="$BACKUP_DIR/settings_$(date +%Y%m%d_%H%M%S).py"

# Crear el directorio de copias de seguridad si no existe
mkdir -p $BACKUP_DIR

# Copiar el archivo de configuración
cp "$SETTINGS_FILE" "$BACKUP_FILE"

log_info "Copia de seguridad del backend de Django completada."