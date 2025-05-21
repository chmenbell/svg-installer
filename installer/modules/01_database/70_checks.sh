#!/bin/bash
# Versión: 1.0.0
# Descripción: Verifica la instalación y configuración de PostgreSQL

source installer/core/logging.sh
source installer/core/config_manager.sh # Añadir esta línea
source installer/core/error_handling.sh
source installer/core/utils.sh

log_info "Verificando la instalación y configuración de PostgreSQL..."

# Verificar si PostgreSQL está instalado
if ! command_exists psql; then
  handle_error "PostgreSQL no está instalado." 1
fi

# Verificar si la base de datos svgviewer_db existe
PGPASSWORD=$(get_config_value DB_PASSWORD) psql -U $(get_config_value DB_USER) -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname = '$(get_config_value DB_NAME)'" | grep -q 1
if [ $? -ne 0 ]; then
  handle_error "La base de datos $(get_config_value DB_NAME) no existe." 1
fi

# Verificar si el usuario svgviewer existe
PGPASSWORD=$(get_config_value DB_PASSWORD) psql -U postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname = '$(get_config_value DB_USER)'" | grep -q 1
if [ $? -ne 0 ]; then
  handle_error "El usuario $(get_config_value DB_USER) no existe." 1
fi

log_info "PostgreSQL instalado y configurado correctamente."