#!/bin/bash
# Versión: 1.0.0
# Descripción: Configura PostgreSQL

source installer/core/logging.sh

log_info "Configurando PostgreSQL..."

# Permitir el acceso remoto a la base de datos
echo "host all all 192.168.1.100/32 md5" >> /etc/postgresql/16/main/pg_hba.conf # Reemplazar con la dirección IP de tu servidor

# Reiniciar PostgreSQL para aplicar los cambios
systemctl restart postgresql

log_info "PostgreSQL configurado."