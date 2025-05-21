#!/bin/bash
# Versión: 2.0.0
# Configura PostgreSQL

source installer/core/logging.sh
source installer/core/config_manager.sh
source installer/core/error_handling.sh
source installer/core/utils.sh

log_info "Configurando PostgreSQL..."

DB_USER="$(get_config_value DB_USER)"
DB_NAME="$(get_config_value DB_NAME)"
DB_PASSWORD="$(get_config_value DB_PASSWORD)"

sudo -u postgres psql -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1 ||
  sudo -u postgres psql -c "CREATE DATABASE \"$DB_NAME\"" || log_warning "No se pudo crear la base de datos $DB_NAME (puede que ya exista)."

sudo -u postgres psql -tc "SELECT 1 FROM pg_roles WHERE rolname = '$DB_USER'" | grep -q 1 ||
  sudo -u postgres psql -c "CREATE USER \"$DB_USER\" WITH PASSWORD '$DB_PASSWORD'" || log_warning "No se pudo crear el usuario $DB_USER (puede que ya exista)."
sudo -u postgres psql -c "ALTER USER \"$DB_USER\" WITH PASSWORD '$DB_PASSWORD'" || log_warning "No se pudo actualizar la contraseña de $DB_USER."

sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE \"$DB_NAME\" TO \"$DB_USER\"" || log_warning "No se pudieron otorgar privilegios a $DB_USER en $DB_NAME."

log_info "PostgreSQL configurado."