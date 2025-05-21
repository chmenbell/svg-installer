# SVGViewer - Instalador

## Seguridad y buenas prácticas

- **No subas nunca tus contraseñas reales a este repo.**
- Configura tus credenciales en `config/settings.conf` (usa `.example` como plantilla).
- Ejecuta siempre los scripts como root usando `sudo`.
- Antes de instalar, ejecuta:  
  `bash installer/hooks/pre_install.sh`
- Después de instalar, ejecuta:  
  `bash installer/hooks/post_install.sh`
- Para restaurar tu base de datos:  
  `bash installer/scripts/restore_db.sh /ruta/al/backup.sql`
- Para desinstalar completamente:  
  `bash installer/scripts/uninstall.sh`

## Backups

- Los backups se guardan en `/var/backups/svgviewer/`.
- Protege los backups con permisos restrictivos.

## Troubleshooting

- Todos los logs muestran fecha y tipo de mensaje.
- Si un script falla, revisa los mensajes `[ERROR]` y consulta este README.