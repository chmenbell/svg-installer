#!/bin/bash
# Versión: 1.0.0
# Descripción: Instala y configura React

source installer/core/logging.sh

log_info "Verificando si Node.js y npm están instalados..."
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
  log_info "Node.js o npm no están instalados. Intentando instalarlos..."
  apt-get update
  apt-get install -y nodejs npm
  if [ $? -ne 0 ]; then
    handle_error "Error al instalar Node.js o npm. La instalación del frontend fallará." 1
  fi
  log_info "Node.js y npm instalados correctamente."
else
  log_info "Node.js y npm ya están instalados."
fi

log_info "Instalando create-react-app globalmente..."
npm install -g create-react-app
if [ $? -ne 0 ]; then
  handle_error "Error al instalar create-react-app. La instalación del frontend fallará." 1
fi

log_info "Creando la aplicación React..."
create-react-app frontend
if [ $? -ne 0 ]; then
  handle_error "Error al crear la aplicación React. La instalación del frontend fallará." 1
fi

log_info "Construyendo la aplicación React para producción..."
cd frontend
npm run build
if [ $? -ne 0 ]; then
  handle_error "Error al construir la aplicación React. La instalación del frontend fallará." 1
fi

log_info "Frontend (React) instalado y configurado."