#!/bin/bash
# Versión: 2.0.0
# Instala los requisitos previos del sistema

set -euo pipefail

source installer/core/logging.sh
source installer/core/error_handling.sh

log_info "Actualizando el sistema..."
case "${PKG_MANAGER:-}" in
  apt-get) apt-get update ;;
  dnf) dnf makecache ;;
  yum) yum makecache ;;
  zypper) zypper refresh ;;
  *) handle_error "Gestor de paquetes no soportado: ${PKG_MANAGER:-no definido}" 1 ;;
esac

log_info "Instalando dependencias..."
case "${PKG_MANAGER:-}" in
  apt-get) apt-get install -y software-properties-common python3-pip nginx postgresql postgresql-contrib ;;
  dnf|yum) $PKG_MANAGER install -y python3-pip nginx postgresql ;;
  zypper) zypper install -y python3-pip nginx postgresql ;;
  *) handle_error "Gestor de paquetes no soportado: ${PKG_MANAGER:-no definido}" 1 ;;
esac

log_info "Requisitos previos instalados."