#!/bin/bash
# Versión: 2.0.0
# Script principal del instalador de SVGViewer

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR/../.."

source installer/core/utils.sh
source installer/core/config_manager.sh
source installer/core/error_handling.sh
source installer/core/logging.sh

detect_package_manager() {
  for pm in apt-get dnf yum zypper; do
    if command_exists "$pm"; then
      echo "$pm"
      return 0
    fi
  done
  log_error "No se encontró un gestor de paquetes soportado (apt, dnf, yum, zypper)."
  exit 1
}

check_required_commands() {
  local cmds=(sudo bash curl git python3 pip3 npm)
  for cmd in "${cmds[@]}"; do
    if ! command_exists "$cmd"; then
      log_error "El comando requerido '$cmd' no está instalado. Por favor instálalo antes de continuar."
      exit 1
    fi
  done
}

main() {
  if [[ $EUID -ne 0 ]]; then
    log_error "Este script debe ser ejecutado como root. Intenta con: sudo $0"
    exit 1
  fi

  check_required_commands
  export PKG_MANAGER=$(detect_package_manager)
  log_info "Gestor de paquetes detectado: $PKG_MANAGER"

  load_config

  if [ -f "installer/hooks/pre_install.sh" ]; then
    bash installer/hooks/pre_install.sh || handle_error "El pre_install falló." 1
  fi

  run_prerequisites
  run_database
  run_backend
  run_frontend
  run_webserver

  if [ -f "installer/hooks/post_install.sh" ]; then
    bash installer/hooks/post_install.sh || handle_error "El post_install falló." 1
  fi

  for test_dir in tests/integration tests/validation; do
    if [ -d "$test_dir" ]; then
      for test_script in "$test_dir"/*.sh; do
        [ -f "$test_script" ] && bash "$test_script"
      done
    fi
  done

  log_info "Instalación de SVGViewer completada."
}

run_module() {
  local module_name="$1"
  local found_script=0
  for script in install.sh checks.sh configure.sh security.sh backups.sh deploy.sh; do
    if [ -f "installer/modules/$module_name/$script" ]; then
      found_script=1
      bash "installer/modules/$module_name/$script"
      if [ $? -ne 0 ]; then
        log_error "El script $script falló en el módulo $module_name."
        exit 1
      fi
    fi
  done
  if [[ $found_script -eq 0 ]]; then
    log_warning "No se encontraron scripts para el módulo $module_name."
  fi
}
run_prerequisites() { run_module "00_prerequisites"; }
run_database()      { run_module "01_database"; }
run_backend()       { run_module "02_backend"; }
run_frontend() {
  if [ -f "installer/modules/03_frontend/build.sh" ]; then
    bash installer/modules/03_frontend/build.sh || handle_error "El build.sh falló para frontend" 1
  else
    log_warning "No se encontró build.sh para 03_frontend."
  fi
}
run_webserver()     { run_module "04_webserver"; }

main "$@"