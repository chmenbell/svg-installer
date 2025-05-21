#!/bin/bash
# Versión: 2.0.0
# Comprobaciones previas a la instalación

source installer/core/logging.sh

log_info "Ejecutando comandos pre-instalación..."

if [[ $EUID -ne 0 ]]; then
  log_error "Este script debe ser ejecutado como root."
  exit 1
fi

REQUIRED_CMDS=(sudo bash curl git python3 pip3 npm)
for cmd in "${REQUIRED_CMDS[@]}"; do
  if ! command -v "$cmd" &>/dev/null; then
    log_error "El comando '$cmd' no está instalado. Por favor instálalo antes de continuar."
    exit 1
  fi
done

log_info "Comandos pre-instalación completados."