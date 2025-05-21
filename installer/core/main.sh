#!/bin/bash
# Versión: 1.0.0
# Descripción: Script principal del instalador de SVGViewer

# Cargar funciones utilitarias
source installer/core/utils.sh
source installer/core/config_manager.sh
source installer/core/error_handling.sh
source installer/core/logging.sh

# Función principal de instalación
main() {
  log_info "Iniciando la instalación de SVGViewer..."

  # Cargar configuración
  load_config

  # Ejecutar script pre-instalación
  if [ -f "installer/hooks/pre_install.sh" ]; then
    log_info "Ejecutando script pre-instalación..."
    bash installer/hooks/pre_install.sh
  else
    log_warning "El archivo pre_install.sh no existe."
  fi

  # Ejecutar módulos de instalación
  run_prerequisites
  run_database
  run_backend
  run_frontend
  run_webserver

  # Ejecutar script post-instalación
  if [ -f "installer/hooks/post_install.sh" ]; then
    log_info "Ejecutando script post-instalación..."
    bash installer/hooks/post_install.sh
  else
    log_warning "El archivo post_install.sh no existe."
  fi

  # Ejecutar pruebas de integración
  log_info "Ejecutando pruebas de integración..."
  for test_script in tests/integration/*.sh; do
    if [ -f "$test_script" ]; then
      log_info "Ejecutando $test_script..."
      bash "$test_script"
    else
      log_warning "El archivo $test_script no existe."
    fi
  done

  # Ejecutar pruebas de validación
  log_info "Ejecutando pruebas de validación..."
  for test_script in tests/validation/*.sh; do
    if [ -f "$test_script" ]; then
      log_info "Ejecutando $test_script..."
      bash "$test_script"
    else
      log_warning "El archivo $test_script no existe."
    fi
  done

  log_info "Instalación de SVGViewer completada."
}

# Funciones para ejecutar los módulos
run_module() {
  local module_name="$1"
  log_info "Ejecutando el módulo $module_name..."

  # Ejecutar install.sh
  if [ -f "installer/modules/$module_name/install.sh" ]; then
    bash installer/modules/$module_name/install.sh
  else
    log_warning "El archivo install.sh no existe en el módulo $module_name."
  fi

  # Ejecutar checks.sh
  if [ -f "installer/modules/$module_name/checks.sh" ]; then
    bash installer/modules/$module_name/checks.sh
  else
    log_warning "El archivo checks.sh no existe en el módulo $module_name."
  fi

  # Ejecutar configure.sh
  if [ -f "installer/modules/$module_name/configure.sh" ]; then
    bash installer/modules/$module_name/configure.sh
  else
    log_warning "El archivo configure.sh no existe en el módulo $module_name."
  fi

  # Ejecutar security.sh
  if [ -f "installer/modules/$module_name/security.sh" ]; then
    bash installer/modules/$module_name/security.sh
  else
    log_warning "El archivo security.sh no existe en el módulo $module_name."
  fi

  # Ejecutar backups.sh
  if [ -f "installer/modules/$module_name/backups.sh" ]; then
    bash installer/modules/$module_name/backups.sh
  else
    log_warning "El archivo backups.sh no existe en el módulo $module_name."
  fi

  # Ejecutar deploy.sh
  if [ -f "installer/modules/$module_name/deploy.sh" ]; then
    bash installer/modules/$module_name/deploy.sh
  else
    log_warning "El archivo deploy.sh no existe en el módulo $module_name."
  fi
}

run_prerequisites() {
  run_module "00_prerequisites"
}

run_database() {
  run_module "01_database"
}

run_backend() {
  run_module "02_backend"
}

run_frontend() {
  # Ejecutar build.sh
  if [ -f "installer/modules/03_frontend/build.sh" ]; then
    bash installer/modules/03_frontend/build.sh
  else
    log_warning "El archivo build.sh no existe en el módulo 03_frontend."
  fi
}

run_webserver() {
  run_module "04_webserver"
}

# Ejecutar la función principal
main "$@"