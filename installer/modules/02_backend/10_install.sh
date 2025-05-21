#!/bin/bash
# Versión: 2.0.0
# Instala y configura el backend de Django

set -euo pipefail

source installer/core/logging.sh
source installer/core/utils.sh
source installer/core/error_handling.sh

log_info "Instalando y configurando el backend de Django..."

<<<<<<< feature/improve-installer-script-logic
=======
<<<<<<< feature/improve-installer-script-logic
>>>>>>> main
log_info "Asegurando que python3-pip está instalado..."
if [ -z "$PKG_MANAGER" ]; then
  handle_error "Variable PKG_MANAGER no definida. No se puede instalar python3-pip." 1
fi

if ! command_exists pip3; then
  log_info "pip3 no encontrado, intentando instalar python3-pip..."
  if [ "$PKG_MANAGER" == "apt-get" ]; then
    apt-get update -y || handle_error "Fallo al actualizar los repositorios con apt-get."
    apt-get install -y python3-pip || handle_error "Fallo al instalar python3-pip con apt-get."
  elif [ "$PKG_MANAGER" == "dnf" ] || [ "$PKG_MANAGER" == "yum" ]; then
    "$PKG_MANAGER" install -y python3-pip || handle_error "Fallo al instalar python3-pip con $PKG_MANAGER."
  elif [ "$PKG_MANAGER" == "zypper" ]; then
    zypper install -y python3-pip || handle_error "Fallo al instalar python3-pip con zypper."
  else
    handle_error "Gestor de paquetes $PKG_MANAGER no soportado para la instalación de python3-pip." 1
  fi

  if ! command_exists pip3; then
    handle_error "pip3 no se encontró después del intento de instalación. No se puede continuar." 1
  fi
  log_info "python3-pip instalado correctamente."
else
  log_info "python3-pip ya está instalado."
fi

# Asegurar que python3-venv está disponible (a menudo parte de python3 o python3-devel)
# El script ya maneja el error si 'python3 -m venv venv' falla.
log_info "Verificando la disponibilidad del módulo venv de Python3..."
if ! python3 -m venv --help > /dev/null 2>&1; then
    log_warning "El módulo venv de Python3 no parece estar completamente funcional o python3-venv no está instalado."
    log_warning "El script intentará continuar, pero la creación del entorno virtual podría fallar si python3-venv (o equivalente) no está presente."
    # No se usa handle_error aquí para permitir que 'python3 -m venv venv' más adelante sea el punto de fallo definitivo si es necesario.
fi
log_info "Verificación de venv completada (la creación del venv más adelante confirmará su funcionalidad)."


if [ -d venv ]; then
  log_info "Eliminando entorno virtual existente..."
<<<<<<< feature/improve-installer-script-logic
=======
=======
if [ -d venv ]; then
>>>>>>> main
>>>>>>> main
  rm -rf venv
fi

python3 -m venv venv || handle_error "Fallo creando el entorno virtual" 1
source venv/bin/activate

pip install --upgrade pip
pip install django gunicorn || handle_error "Fallo instalando Django/gunicorn" 1

if [ ! -d svgviewer ]; then
  django-admin startproject svgviewer || handle_error "Fallo creando el proyecto Django" 1
fi

if [ -f installer/modules/02_backend/gunicorn.sh ]; then
  cp installer/modules/02_backend/gunicorn.sh /usr/local/bin/gunicorn_svgviewer
  chmod 750 /usr/local/bin/gunicorn_svgviewer
fi

deactivate
<<<<<<< feature/improve-installer-script-logic
log_info "Backend de Django instalado y configurado."
=======
log_info "Backend de Django instalado y configurado."
>>>>>>> main
