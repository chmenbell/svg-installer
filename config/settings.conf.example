#!/bin/bash
# Restaura backup de la base de datos PostgreSQL
set -euo pipefail

source installer/core/logging.sh
source installer/core/config_manager.sh

BACKUP_PATH="${1:-}"
if [ -z "$BACKUP_PATH" ] || [ ! -f "$BACKUP_PATH" ]; then
  log_error "Debes indicar un archivo de backup válido como primer argumento."
  exit 1
fi

DB_USER="$(get_config_value DB_USER)"
DB_NAME="$(get_config_value DB_NAME)"
DB_PASSWORD="$(get_config_value DB_PASSWORD)"

log_info "Restaurando la base de datos $DB_NAME desde $BACKUP_PATH..."
PGPASSWORD="$DB_PASSWORD" psql -U "$DB_USER" -d "$DB_NAME" -f "$BACKUP_PATH"

log_info "Restauración completada."