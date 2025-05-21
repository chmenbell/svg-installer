#!/bin/bash
# Versión: 1.1.0
# Descripción: Instala y configura el backend de Django

source installer/core/logging.sh
source installer/core/utils.sh
source installer/core/error_handling.sh

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
python3 -m venv venv || handle_error "Fallo creando el entorno virtual" 1

# Activar el entorno virtual
source venv/bin/activate

# Instalar Django y gunicorn en el entorno virtual
log_info "Instalando Django y gunicorn..."
pip install --upgrade pip
pip install django gunicorn || handle_error "Fallo instalando Django/gunicorn" 1

# Crear el proyecto Django si no existe
if [ ! -d svgviewer ]; then
  log_info "Creando el proyecto Django..."
  django-admin startproject svgviewer || handle_error "Fallo creando el proyecto Django" 1
fi

# Copiar el script gunicorn.sh al directorio /usr/bin si existe
if [ -f installer/modules/02_backend/gunicorn.sh ]; then
  log_info "Copiando el script gunicorn.sh al directorio /usr/bin..."
  cp installer/modules/02_backend/gunicorn.sh /usr/bin/gunicorn_svgviewer
  chmod +x /usr/bin/gunicorn_svgviewer
else
  log_warning "El script gunicorn.sh no se encontró, omitiendo copia."
fi

# Desactivar el entorno virtual
deactivate

log_info "Backend de Django instalado y configurado."