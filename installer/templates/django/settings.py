
# Copiar la plantilla de settings.py
log_info "Copiando la plantilla de settings.py..."
cp installer/templates/django/settings.py.template svgviewer/settings.py

# Configurar la conexión a la base de datos
log_info "Configurando la conexión a la base de datos..."
sed -i "s/ENGINE': 'django.db.backends.sqlite3'/ENGINE': 'django.db.backends.postgresql'/" svgviewer/settings.py
sed -i "s/NAME': BASE_DIR \/ 'db.sqlite3'/NAME': 'svgviewer_db'/" svgviewer/settings.py
sed -i "s/'USER': ''/'USER': 'svgviewer'/" svgviewer/settings.py
sed -i "s/'PASSWORD': ''/'PASSWORD': 'password123'/" svgviewer/settings.py
sed -i "s/'HOST': ''/'HOST': 'localhost'/" svgviewer/settings.py
sed -i "s/'PORT': ''/'PORT': '5432'/" svgviewer/settings.py

# Realizar las migraciones iniciales
log_info "Realizando las migraciones iniciales..."
python manage.py migrate
if [ $? -ne 0 ]; then
  log_error "Error al realizar las migraciones iniciales. La instalación fallará."
  exit 1
fi

# Crear un usuario administrador
log_info "Creando un usuario administrador..."
python manage.py createsuperuser --noinput --username admin --email admin@example.com
if [ $? -ne 0 ]; then
  log_error "Error al crear el usuario administrador. La instalación fallará."
  exit 1
fi

log_info "Django instalado y configurado."