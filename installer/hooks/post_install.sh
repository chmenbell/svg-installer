#!/bin/bash
# Versión: 2.0.0
# Comandos post-instalación

source installer/core/logging.sh
source installer/core/config_manager.sh

log_info "Ejecutando comandos post-instalación..."

DOMAIN="$(get_config_value DOMAIN)"
log_info "¡Felicidades! La instalación de SVGViewer se ha completado con éxito."
log_info "Para acceder a la aplicación, abre un navegador web y navega a https://$DOMAIN"

log_info "Comandos post-instalación completados."