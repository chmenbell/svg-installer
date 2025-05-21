#!/bin/bash
# Versión: 2.0.0
# Configura copias de seguridad automáticas de PostgreSQL

set -euo pipefail

source installer/core/logging.sh
source installer/core/config_manager.sh
source installer/core/error_handling.sh

log_info "Configurando copias de seguridad automáticas de la base de datos PostgreSQL..."

DB_USER="$(get_config_value DB_USER)"
DB_NAME="$(get_config_value DB_NAME)"
DB_PASSWORD="$(get_config_value DB_PASSWORD)"
BACKUP_DIR="/var/backups/svgviewer"
BACKUP_FILE="$BACKUP_DIR/svgviewer_db_$(date +%Y%m%d_%H%M%S).sql"

mkdir -p "$BACKUP_DIR"
chmod 700 "$BACKUP_DIR"

log_info "Creando copia de seguridad de la base de datos PostgreSQL..."
if ! PGPASSWORD="$DB_PASSWORD" pg_dump -U "$DB_USER" -d "$DB_NAME" -f "$BACKUP_FILE"; then
  handle_error "Error al crear la copia de seguridad de la base de datos $DB_NAME" 1
fi

chmod 600 "$BACKUP_FILE"
log_info "Copia de seguridad realizada en $BACKUP_FILE."