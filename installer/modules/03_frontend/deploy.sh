#!/bin/bash
# Versión: 1.0.0
# Descripción: Despliega los archivos estáticos de la aplicación React

source installer/core/logging.sh

log_info "Desplegando los archivos estáticos de la aplicación React..."

# Definir variables
FRONTEND_BUILD_DIR="/home/chris/svgviewer-installer/frontend/build"
STATIC_FILES_DIR="/var/www/svgviewer/static" # Reemplazar con la ruta correcta

# Crear el directorio de archivos estáticos si no existe
mkdir -p $STATIC_FILES_DIR

# Copiar los archivos estáticos al directorio correcto
cp -r $FRONTEND_BUILD_DIR/* $STATIC_FILES_DIR

log_info "Archivos estáticos de la aplicación React desplegados."