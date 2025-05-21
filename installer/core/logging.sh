#!/bin/bash
# Versión: 2.0.0
# Funciones de logging centralizado para SVGViewer Installer

set -euo pipefail

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}

log_info() {
  echo -e "$(timestamp) ${GREEN}[INFO]${NC} $1"
}

log_warning() {
  echo -e "$(timestamp) ${YELLOW}[WARNING]${NC} $1"
}

log_error() {
  echo -e "$(timestamp) ${RED}[ERROR]${NC} $1"
}