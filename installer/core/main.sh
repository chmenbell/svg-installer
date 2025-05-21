#!/bin/bash
# Versión: 2.0.0
# Script principal del instalador de SVGViewer

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR/../.."

source installer/core/utils.sh
source installer/core/config_manager.sh
source installer/core/error_handling.sh
source installer/core/logging.sh

detect_package_manager() {
  if command -v apt-get &>/dev/null; then
    echo "apt-get"
  elif command -v dnf &>/dev/null; then
    echo "dnf"
  elif command -v yum &>/dev/null; then
    echo "yum"
  elif command -v zypper &>/dev/null; then
    echo "zypper"
  else
    log_error "No se encontró un gestor de paquetes soportado (apt, dnf, yum, zypper)."
    exit 1
  fi
}

check_required_commands() {
  local cmds=(sudo bash curl git python3 pip3 npm)
  for cmd in "${cmds[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
      log_error "El comando requerido '$cmd' no está instalado. Por favor instálalo antes de continuar."
      exit 1
    fi
  done
}

main() {
  if [[ $EUID -ne 0 ]]; then
    log_error "Este script debe ser ejecutado como root."
    exit 1
  fi

  check_required_commands
  export PKG_MANAGER=$(detect_package_manager)
  log_info "Gestor de paquetes detectado: $PKG_MANAGER"

  load_config

  [ -f "installer/hooks/pre_install.sh" ] && bash installer/hooks/pre_install.sh

  run_prerequisites
  run_database
  run_backend
  run_frontend
  run_webserver

  [ -f "installer/hooks/post_install.sh" ] && bash installer/hooks/post_install.sh

  for test_dir in tests/integration tests/validation; do
    if [ -d "$test_dir" ]; then
      for test_script in $test_dir/*.sh; do
        [ -f "$test_script" ] && bash "$test_script"
      done
    fi
  done

  log_info "Instalación de SVGViewer completada."
}

run_module() {
  local module_name="$1"
  for script in install.sh checks.sh configure.sh security.sh backups.sh deploy.sh; do
    if [ -f "installer/modules/$module_name/$script" ]; then
      bash "installer/modules/$module_name/$script"
      if [ $? -ne 0 ]; then
        log_error "El script $script falló en el módulo $module_name."
        exit 1
      fi
    fi
  done
}
run_prerequisites() { run_module "00_prerequisites"; }
run_database()      { run_module "01_database"; }
run_backend()       { run_module "02_backend"; }
run_frontend() {
  if [ -f "installer/modules/03_frontend/build.sh" ]; then
    bash installer/modules/03_frontend/build.sh
    [ $? -ne 0 ] && log_error "El script build.sh falló en el módulo 03_frontend." && exit 1
  fi
}
run_webserver()     { run_module "04_webserver"; }

main "$@"