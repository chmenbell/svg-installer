#!/bin/bash
# Versión: 1.0.0
# Descripción: Configura PostgreSQL...

source installer/core/logging.sh
source installer/core/config_manager.sh # Añadir esta línea
source installer/core/error_handling.sh
source installer/core/utils.sh

log_info "Instalando PostgreSQL..."
apt-get install -y postgresql postgresql-contrib
if [ $? -ne 0 ]; then
  handle_error "Error al instalar..." 1
fi

log_info "Configurando PostgreSQL..."

# Definir variables
DB_USER="$(get_config_value DB_USER)"
DB_NAME="$(get_config_value DB_NAME)"
DB_PASSWORD="$(get_config_value DB_PASSWORD)"  # ¡Cambiar esto en producción!

# Crear la base de datos
PGPASSWORD="$DB_PASSWORD" psql -w -U postgres -c "CREATE DATABASE \"$DB_NAME\""
if [ $? -ne 0 ]; then
  handle_error "Error al crear la base de datos $DB_NAME" 1
fi

# Crear el usuario
PGPASSWORD="$DB_PASSWORD" psql -w -U postgres -c "CREATE USER \"$DB_USER\" WITH PASSWORD '$DB_PASSWORD'"
if [ $? -ne 0 ]; then
  handle_error "Error al crear el usuario $DB_USER" 1
fi

# Otorgar privilegios al usuario en la base de datos
PGPASSWORD="$DB_PASSWORD" psql -w -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE \"$DB_NAME\" TO \"$DB_USER\""
if [ $? -ne 0 ]; then
  handle_error "Error al otorgar privilegios al usuario $DB_USER en la base de datos $DB_NAME" 1
fi

log_info "PostgreSQL instalado y configurado."