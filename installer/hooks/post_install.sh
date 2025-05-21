#!/bin/bash
# Hook de postinstalación para SVGViewer
set -euo pipefail

source installer/core/logging.sh

log_info "Ejecutando hook de postinstalación..."

if [ -f config/settings.conf ]; then
  source config/settings.conf
  log_info "Accede a SVGViewer en: http://$DOMAIN/"
fi

log_info "Hook de postinstalación completado."