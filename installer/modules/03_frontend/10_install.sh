#!/bin/bash
# Versión: 2.0.0
# Construye la aplicación React

set -euo pipefail

source installer/core/logging.sh
<<<<<<< feature/improve-installer-script-logic
source installer/core/utils.sh # Needed for command_exists
source installer/core/error_handling.sh # Needed for handle_error

log_info "Asegurando que Node.js y npm están instalados..."
if [ -z "$PKG_MANAGER" ]; then
  handle_error "Variable PKG_MANAGER no definida. No se puede instalar Node.js/npm." 1
fi

if ! command_exists npm; then
  log_info "npm no encontrado, intentando instalar Node.js y npm..."
  if [ "$PKG_MANAGER" == "apt-get" ]; then
    sudo apt-get update -y || handle_error "Fallo al actualizar los repositorios con apt-get."
    sudo apt-get install -y nodejs npm || handle_error "Fallo al instalar Node.js/npm con apt-get."
  elif [ "$PKG_MANAGER" == "dnf" ] || [ "$PKG_MANAGER" == "yum" ]; then
    # Para dnf, podría ser necesario habilitar un módulo específico de Node.js, ej: nodejs:18
    # Por ahora, intentamos la instalación directa.
    sudo "$PKG_MANAGER" install -y nodejs npm || handle_error "Fallo al instalar Node.js/npm con $PKG_MANAGER."
  elif [ "$PKG_MANAGER" == "zypper" ]; then
    sudo "$PKG_MANAGER" install -y nodejs npm || handle_error "Fallo al instalar Node.js/npm con zypper."
  else
    handle_error "Gestor de paquetes $PKG_MANAGER no soportado para la instalación de Node.js/npm." 1
  fi

  if ! command_exists npm; then
    handle_error "npm no se encontró después del intento de instalación. No se puede continuar." 1
  fi
  log_info "Node.js y npm instalados correctamente."
else
  log_info "Node.js y npm ya están instalados."
fi

FRONTEND_DIR="frontend" # <--- RUTA CORREGIDA

if [ ! -d "$FRONTEND_DIR" ]; then
  log_error "El directorio del frontend no existe: $FRONTEND_DIR (relativo a la raíz del proyecto)"
  exit 1
fi

log_info "Cambiando al directorio del frontend: $FRONTEND_DIR"
=======

FRONTEND_DIR="/absolute/path/to/frontend" # <--- AJUSTA ESTA RUTA

if [ ! -d "$FRONTEND_DIR" ]; then
  log_error "El directorio del frontend no existe: $FRONTEND_DIR"
  exit 1
fi

>>>>>>> main
cd "$FRONTEND_DIR"

log_info "Instalando dependencias de frontend..."
npm install

log_info "Construyendo la aplicación React..."
npm run build

log_info "Aplicación React construida exitosamente."
