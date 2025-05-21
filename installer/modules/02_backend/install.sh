#!/bin/bash
# Versión: 2.0.0
# Instala y configura el backend de Django

source installer/core/logging.sh
source installer/core/utils.sh
source installer/core/error_handling.sh

log_info "Instalando y configurando el backend de Django..."

[ -d venv ] && rm -rf venv

python3 -m venv venv || handle_error "Fallo creando el entorno virtual" 1
source venv/bin/activate

pip install --upgrade pip
pip install django gunicorn || handle_error "Fallo instalando Django/gunicorn" 1

if [ ! -d svgviewer ]; then
  django-admin startproject svgviewer || handle_error "Fallo creando el proyecto Django" 1
fi

if [ -f installer/modules/02_backend/gunicorn.sh ]; then
  cp installer/modules/02_backend/gunicorn.sh /usr/bin/gunicorn_svgviewer
  chmod +x /usr/bin/gunicorn_svgviewer
fi

deactivate
log_info "Backend de Django instalado y configurado."