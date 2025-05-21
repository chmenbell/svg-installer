#!/bin/bash
# Versión: 2.0.0
# Funciones utilitarias para SVGViewer Installer

set -euo pipefail

command_exists() {
  command -v "$1" >/dev/null 2>&1
}