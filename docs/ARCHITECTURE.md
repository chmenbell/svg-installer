# Arquitectura del instalador de SVGViewer

El instalador de SVGViewer está compuesto por los siguientes módulos:

*   `00_prerequisites`: Instala los requisitos previos del sistema.
*   `01_database`: Instala y configura la base de datos PostgreSQL.
*   `02_backend`: Instala y configura el backend de Django.
*   `03_frontend`: Instala y configura el frontend de React.
*   `04_webserver`: Configura el servidor web Nginx.

Cada módulo contiene los siguientes archivos:

*   `install.sh`: Instala el componente correspondiente.
*   `checks.sh`: Verifica que el componente se ha instalado correctamente.
*   `configure.sh`: Realiza configuraciones adicionales en el componente.
*   `security.sh`: Aplica medidas de seguridad al componente.

El script principal del instalador es `installer/core/main.sh`. Este script ejecuta los módulos en el orden correcto y realiza las tareas de configuración necesarias.