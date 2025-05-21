#!/bin/bash
# Versión: 1.0.0
# Descripción: Contiene funciones utilitarias para el instalador

# Función para verificar si un comando está instalado
command_exists() {
  command -v "$1" >/dev/null 2>&1
}