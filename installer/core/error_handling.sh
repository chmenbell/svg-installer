#!/bin/bash
# Versión: 2.0.0
# Manejo centralizado de errores

set -euo pipefail
source installer/core/logging.sh

handle_error() {
  local error_message="$1"
  local error_code="${2:-1}"
  log_error "$error_message"
  exit "$error_code"
}