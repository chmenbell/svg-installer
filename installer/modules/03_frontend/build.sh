#!/bin/bash
# Versión: 1.0.0
# Descripción: Construye la aplicación React

source installer/core/logging.sh

log_info "Construyendo la aplicación React..."

# Navegar al directorio del frontend
cd /home/chris/svgviewer-installer/frontend # Reemplazar con la ruta absoluta a tu directorio frontend
if [ $? -ne 0 ]; then
  log_error "Error al navegar al directorio del frontend."
  exit 1
fi
# Instalar las dependencias
npm install

# Construir la aplicación
npm run build

# Volver al directorio principal del instalador
cd ..

log_info "Aplicación React construida."