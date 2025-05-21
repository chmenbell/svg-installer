#!/bin/bash
# Versión: 1.0.0
# Descripción: Gestiona la configuración del instalador

source installer/core/utils.sh
source installer/core/error_handling.sh
source installer/core/logging.sh

# Definir el archivo de configuración por defecto
CONFIG_FILE="config/settings.conf"

# Función para cargar la configuración
load_config() {
  log_info "Cargando configuración desde $CONFIG_FILE..."

  # Verificar si el archivo de configuración existe
  if [ ! -f "$CONFIG_FILE" ]; then
    log_error "El archivo de configuración $CONFIG_FILE no existe."
    exit 1
  fi

  # Cargar la configuración
  source "$CONFIG_FILE"

  log_info "Configuración cargada."
}

# Función para obtener un valor de configuración
get_config_value() {
  local config_key="$1"

  # Verificar si la clave de configuración existe
  if [ -z "$(eval "echo \$$config_key")" ]; then
    log_error "La clave de configuración $config_key no existe."
    return 1
  fi

  # Devolver el valor de configuración
  eval "echo \$$config_key"
}