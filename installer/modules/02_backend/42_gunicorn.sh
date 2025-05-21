#!/bin/bash
# Versión: 2.0.0
# Inicia el servidor Gunicorn para Django

set -euo pipefail

source installer/core/logging.sh

PROJECT_DIR="/absolute/path/to/svgviewer" # <--- AJUSTA ESTA RUTA
VENV_DIR="/absolute/path/to/venv"        # <--- AJUSTA ESTA RUTA

if [ ! -d "$PROJECT_DIR" ] || [ ! -d "$VENV_DIR" ]; then
  log_error "No se encuentra el directorio del proyecto o del entorno virtual."
  exit 1
fi

cd "$PROJECT_DIR"
source "$VENV_DIR/bin/activate"

log_info "Iniciando Gunicorn para SVGViewer..."
gunicorn --bind 0.0.0.0:8000 svgviewer.wsgi

deactivate