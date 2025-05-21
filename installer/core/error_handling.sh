#!/bin/bash
# Versión: 1.0.0
# Descripción: Gestiona los errores del instalador

source installer/core/logging.sh
source installer/core/utils.sh

# Función para gestionar los errores
handle_error() {
  local error_message="$1"
  local error_code="$2"

  log_error "$error_message"

  # Realizar acciones adicionales en caso de error
  # Por ejemplo, enviar un correo electrónico al administrador

  exit "$error_code"
}