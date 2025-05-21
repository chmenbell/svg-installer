#!/bin/bash
# Versión: 1.0.0
# Descripción: Aplica medidas de seguridad a Django

source installer/core/logging.sh

log_info "Aplicando medidas de seguridad a Django..."

# Deshabilitar el modo DEBUG en producción
sed -i "s/DEBUG = True/DEBUG = False/" svgviewer/settings.py

# Configurar el middleware de seguridad
sed -i "s/'django.middleware.security.SecurityMiddleware',/'django.middleware.security.SecurityMiddleware',\\n    'django.middleware.clickjacking.XFrameOptionsMiddleware',/" svgviewer/settings.py

log_info "Medidas de seguridad aplicadas a Django."