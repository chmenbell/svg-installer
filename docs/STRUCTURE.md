svgviewer-installer/
├── config/
│   └── settings.conf
├── installer/
│   ├── core/
│   │   ├── config_manager.sh
│   │   ├── error_handling.sh
│   │   ├── logging.sh
│   │   ├── main.sh
│   │   └── utils.sh
│   ├── hooks/
│   │   ├── post_install.sh
│   │   └── pre_install.sh
│   ├── modules/
│   │   ├── 00_prerequisites/
│   │   │   ├── backups.sh
│   │   │   ├── checks.sh
│   │   │   ├── configure.sh
│   │   │   ├── deploy.sh
│   │   │   ├── install.sh
│   │   │   └── security.sh
│   │   ├── 01_database/
│   │   │   ├── backups.sh
│   │   │   ├── checks.sh
│   │   │   ├── configure.sh
│   │   │   ├── deploy.sh
│   │   │   ├── install.sh
│   │   │   └── security.sh
│   │   ├── 02_backend/
│   │   │   ├── backups.sh
│   │   │   ├── checks.sh
│   │   │   ├── configure.sh
│   │   │   ├── deploy.sh
│   │   │   ├── install.sh
│   │   │   └── security.sh
│   │   ├── 03_frontend/
│   │   │   ├── backups.sh
│   │   │   ├── build.sh
│   │   │   ├── checks.sh
│   │   │   ├── configure.sh
│   │   │   ├── deploy.sh
│   │   │   ├── install.sh
│   │   │   └── security.sh
│   │   └── 04_webserver/
│   │   │   ├── backups.sh
│   │   │   ├── checks.sh
│   │   │   ├── configure.sh
│   │   │   ├── deploy.sh
│   │   │   ├── install.sh
│   │   │   └── security.sh
├── docs/
│   ├── ARCHITECTURE.md
│   ├── CONFIG.md
│   └── INSTALL.md
├── frontend/
│   ├── (Archivos de la aplicación React)
├── gunicorn.sh
├── svgviewer/
│   ├── (Archivos del proyecto Django)
├── tests/
│   ├── integration/
│   └── validation/
└── venv/
    ├── (Archivos del entorno virtual de Python)