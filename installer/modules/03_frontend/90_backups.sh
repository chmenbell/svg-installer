#!/bin/bash
# Versión: 1.0.0
# Descripción: Configura copias de seguridad del frontend de React

source installer/core/logging.sh

log_info "Configurando copias de seguridad del frontend de React..."

# Definir variables
BACKUP_DIR="/var/backups/svgviewer"
ENV_FILE="frontend/.env"
PACKAGE_FILE="frontend/package.json"
BACKUP_ENV_FILE="$BACKUP_DIR/env_$(date +%Y%m%d_%H%M%S)"
BACKUP_PACKAGE_FILE="$BACKUP_DIR/package_$(date +%Y%m%d_%H%M%S).json"

# Crear el directorio de copias de seguridad si no existe
mkdir -p $BACKUP_DIR

# Copiar los archivos de configuración
cp "$ENV_FILE" "$BACKUP_ENV_FILE"
cp "$PACKAGE_FILE" "$BACKUP_PACKAGE_FILE"

log_info "Copia de seguridad del frontend de React completada."