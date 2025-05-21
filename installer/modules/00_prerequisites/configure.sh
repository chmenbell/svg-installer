#!/bin/bash
# Versión: 1.0.0
# Descripción: Configura los requisitos previos del sistema

source installer/core/logging.sh

log_info "Configurando requisitos previos..."

# Configurar el firewall para permitir el tráfico HTTP y HTTPS
ufw allow http
ufw allow https

log_info "Requisitos previos configurados."