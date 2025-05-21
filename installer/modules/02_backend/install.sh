#!/bin/bash
# Versión: 1.0.0
# Descripción: Instala y configura el backend de Django

source installer/core/logging.sh
source installer/core/utils.sh

log_info "Instalando y configurando el backend de Django..."

# Verificar si Python 3 está instalado
if ! command_exists python3; then
  handle_error "Python 3 no está instalado." 1
fi

# Verificar si pip está instalado
if ! command_exists pip3; then
  handle_error "pip no está instalado." 1
fi

# Crear el entorno virtual
log_info "Creando el entorno virtual..."
python3 -m venv venv

# Activar el entorno virtual
source venv/bin/activate

# Instalar Django
log_info "Instalando Django..."
pip3 install django gunicorn

# Crear el proyecto Django
log_info "Creando el proyecto Django..."
django-admin startproject svgviewer

# Copiar el script gunicorn.sh al directorio /usr/bin
log_info "Copiando el script gunicorn.sh al directorio /usr/bin..."
cp ../gunicorn.sh /usr/bin/gunicorn_svgviewer
chmod +x /usr/bin/gunicorn_svgviewer

# Desactivar el entorno virtual
deactivate

log_info "Backend de Django instalado y configurado."