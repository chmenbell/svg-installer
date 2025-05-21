#!/bin/bash
# Hook de preinstalación para SVGViewer
set -euo pipefail

source installer/core/logging.sh

log_info "Ejecutando hook de preinstalación..."

MIN_FREE_MB=1024
FREE_MB=$(df --output=avail / | tail -1)
if [ "$FREE_MB" -lt "$MIN_FREE_MB" ]; then
  log_error "Espacio en disco insuficiente. Se requieren al menos $MIN_FREE_MB MB libres."
  exit 1
fi

log_info "Hook de preinstalación completado."