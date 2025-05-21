#!/bin/bash
# Versión: 2.0.0
# Script principal del instalador de SVGViewer

set -euo pipefail

# Limpiar o rotar log al inicio
LOGFILE="${SVG_INSTALLER_LOGFILE:-installer.log}"
if [ -f "$LOGFILE" ]; then
    mv "$LOGFILE" "${LOGFILE%.*}_$(date '+%Y%m%d_%H%M%S').log"
fi
: > "$LOGFILE"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR/../.."

source installer/core/utils.sh
source installer/core/config_manager.sh
source installer/core/error_handling.sh
source installer/core/logging.sh

# Nueva función: Diagnosticar y corregir problemas de permisos en el directorio venv
check_and_fix_venv_permissions() {
    local venv_dir="venv"

    log_info "Verificando permisos del directorio $venv_dir..."
    
    if [ ! -d "$venv_dir" ]; then
        log_error "El directorio $venv_dir no existe. Por favor, asegúrate de que la configuración sea correcta."
        exit 1
    fi

    # Verificar permisos
    if [ ! -w "$venv_dir" ]; then
        log_warning "No se tienen permisos de escritura en $venv_dir. Intentando corregir permisos..."
        sudo chmod -R 755 "$venv_dir" || {
            log_error "No se pudieron corregir los permisos de $venv_dir."
            exit 1
        }
        sudo chown -R "$(whoami):$(whoami)" "$venv_dir" || {
            log_error "No se pudo cambiar el propietario del directorio $venv_dir."
            exit 1
        }
        log_info "Permisos del directorio $venv_dir corregidos exitosamente."
    else
        log_info "El directorio $venv_dir ya tiene permisos adecuados."
    fi

    # Opción para recrear el entorno si es necesario
    if [ ! -f "$venv_dir/bin/activate" ]; then
        log_warning "El entorno virtual parece estar corrupto. Recreando el directorio $venv_dir..."
        rm -rf "$venv_dir"
        python3 -m venv "$venv_dir" || {
            log_error "No se pudo recrear el entorno virtual en $venv_dir."
            exit 1
        }
        log_info "El entorno virtual en $venv_dir fue recreado exitosamente."
    fi
}

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
  local cmds=(sudo bash curl git python3)
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

  # Llamada a la nueva función de verificación y corrección de permisos
  check_and_fix_venv_permissions

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
  local module_path="installer/modules/$module_name"
  local found_script=0

  if [ ! -d "$module_path" ]; then
    log_warning "Directorio del módulo $module_name no encontrado en $module_path."
    return
  fi

  local script_files=()
  while IFS= read -r script_file; do
    script_files+=("$script_file")
  done < <(find "$module_path" -maxdepth 1 -name "*.sh" -type f -printf "%f\\n" | sort)

  for script in "${script_files[@]}"; do
    if [ "$module_name" == "03_frontend" ] && [ "$script" == "build.sh" ]; then
      continue # Excluir build.sh para el módulo 03_frontend
    fi

    local script_path="$module_path/$script"
    log_info "Ejecutando script: $script_path"
    found_script=1
    bash "$script_path"
    if [ $? -ne 0 ]; then
      log_error "El script $script_path falló en el módulo $module_name."
      exit 1
    fi
  done

  if [[ $found_script -eq 0 ]]; then
    if [ "$module_name" == "03_frontend" ]; then
      # No advertir si solo era build.sh el único script, ya que se maneja por separado
      local only_build_sh=1
      for s in "${script_files[@]}"; do
        if [ "$s" != "build.sh" ]; then
          only_build_sh=0
          break
        fi
      done
      if [ $only_build_sh -eq 0 ]; then
         log_warning "No se encontraron scripts aplicables (excluyendo build.sh) para el módulo $module_name en $module_path."
      fi
    else
      log_warning "No se encontraron scripts .sh para el módulo $module_name en $module_path."
    fi
  fi
}
run_prerequisites() { run_module "00_prerequisites"; }
run_database()      { run_module "01_database"; }
run_backend()       { run_module "02_backend"; }
run_frontend() {
  local build_script_path="installer/modules/03_frontend/build.sh"
  if [ -f "$build_script_path" ]; then
    log_info "Ejecutando script de build: $build_script_path"
    bash "$build_script_path" || handle_error "El script $build_script_path falló." 1
  else
    log_warning "No se encontró $build_script_path para 03_frontend."
  fi
  run_module "03_frontend"
}
run_webserver()     { run_module "04_webserver"; }

main "$@"
