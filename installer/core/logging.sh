#!/bin/bash
# Versión: 2.0.0
# Funciones de logging centralizado para SVGViewer Installer

set -euo pipefail

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

LOGFILE="${SVG_INSTALLER_LOGFILE:-installer.log}"

timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}

log_info() {
  local msg="$(timestamp) [INFO] $1"
  echo -e "${GREEN}${msg}${NC}"
  echo "$msg" >> "$LOGFILE"
}

log_warning() {
  local msg="$(timestamp) [WARNING] $1"
  echo -e "${YELLOW}${msg}${NC}"
  echo "$msg" >> "$LOGFILE"
}

log_error() {
  local msg="$(timestamp) [ERROR] $1"
  echo -e "${RED}${msg}${NC}"
  echo "$msg" >> "$LOGFILE"
}
