#!/bin/bash
# Versión: 2.0.0
# Gestión de configuración para SVGViewer Installer

set -euo pipefail
source installer/core/logging.sh
source installer/core/error_handling.sh

CONFIG_FILE="config/settings.conf"

load_config() {
  log_info "Cargando configuración desde $CONFIG_FILE..."
  if [ ! -f "$CONFIG_FILE" ]; then
    handle_error "El archivo de configuración $CONFIG_FILE no existe." 1
  fi
  # shellcheck disable=SC1090
  source "$CONFIG_FILE"
  log_info "Configuración cargada."
}

get_config_value() {
  local config_key="$1"
  if [ -z "${!config_key:-}" ]; then
    log_error "La clave de configuración $config_key no existe."
    return 1
  fi
  echo "${!config_key}"
}