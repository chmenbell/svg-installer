#!/bin/bash
# Versión: 1.0.0
# Descripción: Inicia el servidor Gunicorn

# Navegar al directorio del proyecto Django
cd svgviewer

# Activar el entorno virtual
source /home/chris/svgviewer-installer/venv/bin/activate # Reemplazar con la ruta absoluta a tu entorno virtual

# Copiar el script gunicorn.sh al directorio /usr/bin
log_info "Copiando el script gunicorn.sh al directorio /usr/bin..."
cp /home/chris/svgviewer-installer/gunicorn.sh /usr/bin/gunicorn_svgviewer # Reemplazar con la ruta absoluta a tu script gunicorn.sh
chmod +x /usr/bin/gunicorn_svgviewer

# Iniciar el servidor Gunicorn
gunicorn --bind 0.0.0.0:8000 svgviewer.wsgi

# Desactivar el entorno virtual al salir
deactivate