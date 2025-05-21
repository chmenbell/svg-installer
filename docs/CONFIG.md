# Guía de configuración de SVGViewer

## Archivo de configuración principal

El archivo de configuración principal del instalador es `config/settings.conf`. Este archivo contiene las siguientes opciones:

*   `DOMAIN`: El dominio de la aplicación SVGViewer.
*   `DB_USER`: El nombre de usuario de la base de datos.
*   `DB_NAME`: El nombre de la base de datos.
*   `DB_PASSWORD`: La contraseña de la base de datos.

## Configuración de Nginx

El archivo de configuración de Nginx se encuentra en `/etc/nginx/sites-available/svgviewer`. Puedes modificar este archivo para personalizar la configuración de Nginx.

## Solución de problemas

Si tienes problemas con la configuración, asegúrate de que:

*   El archivo `config/settings.conf` contiene los valores correctos.
*   El archivo de configuración de Nginx es válido.
*   Los servicios Nginx y PostgreSQL están en ejecución.