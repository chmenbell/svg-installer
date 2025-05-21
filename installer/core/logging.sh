#!/bin/bash
# Versión: 1.0.0
# Descripción: Funciones de logging para el instalador de SVGViewer

# Función para registrar información
log_info() {
  echo "[INFO] $1"
}

# Función para registrar advertencias
log_warning() {
  echo "[WARNING] $1"
}

# Función para registrar errores
log_error() {
  echo "[ERROR] $1"
}