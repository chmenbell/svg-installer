#!/bin/bash
# Versión: 1.0.0
# Descripción: Configura copias de seguridad automáticas de la base de datos PostgreSQL

source installer/core/logging.sh
source installer/core/config_manager.sh
source installer/core/error_handling.sh
source installer/core/utils.sh

log_info "Configurando copias de seguridad automáticas de la base de datos PostgreSQL..."

# Definir variables
DB_USER="$(get_config_value DB_USER)"
DB_NAME="$(get_config_value DB_NAME)"
DB_PASSWORD="$(get_config_value DB_PASSWORD)" # ¡Cambiar esto en producción!
BACKUP_DIR="/var/backups/svgviewer"
BACKUP_FILE="$BACKUP_DIR/svgviewer_db_$(date +%Y%m%d_%H%M%S).sql"

# Crear el directorio de copias de seguridad si no existe
mkdir -p $BACKUP_DIR

# Crear el script de copia de seguridad
log_info "Creando copia de seguridad de la base de datos PostgreSQL..."
PGPASSWORD="$DB_PASSWORD" pg_dump -U "$DB_USER" -d "$DB_NAME" -f "$BACKUP_FILE"
if [ $? -ne 0 ]; then
  handle_error "Error al crear la copia de seguridad de la base de datos $DB_NAME" 1
fi

log_info "Copias de seguridad automáticas de la base de datos PostgreSQL configuradas."