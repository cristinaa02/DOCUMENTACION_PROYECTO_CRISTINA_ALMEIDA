#!/bin/bash

WEB_ROUTE="/var/www/html"
WEB_ROUTE_PRIVADA="/var/www/html_private"

# Instalar Nginx, PHP-FPM, PHP, Python y Cliente SQL
sudo apt update
sudo apt install -y nginx php-fpm php mariadb-client
sudo apt install -y python3 python3-pip
sudo pip3 install mysql-connector-python --break-system-packages

# --- WEB_ROUTE ---
# Navegar hasta el directorio donde guardar los archivos.
cd "$WEB_ROUTE"
sudo cp -r /vagrant/src/* . # Copiar los archivos necesarios al directorio actual.

# Permisos para acceder a los archivos.
sudo chown -R www-data:www-data "$WEB_ROUTE"
sudo chmod -R 755 "$WEB_ROUTE"

# --- WEB_ROUTE ---
sudo mkdir -p "$WEB_ROUTE_PRIVADA"
cd "$WEB_ROUTE_PRIVADA"
sudo cp -r /vagrant/src_empresa/* .
sudo chown -R www-data:www-data "$WEB_ROUTE_PRIVADA"
sudo chmod -R 755 "$WEB_ROUTE_PRIVADA"


# Detectar versión de PHP
PHP_VERSION=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')
echo "PHP Version detected: $PHP_VERSION"

# Configuración Nginx
sudo tee /etc/nginx/sites-available/myweb << EOF
server {
    listen 80;
    server_name _;
    root $WEB_ROUTE;
    index index.php index.html;

    # Logs
    access_log /var/log/nginx/app_access.log;
    error_log /var/log/nginx/app_error.log;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php$PHP_VERSION-fpm.sock;
    }
}

server {
    listen 82;
    server_name _;
    root $WEB_ROUTE_PRIVADA;
    index index.php index.html;

    # Logs
    access_log /var/log/nginx/app_access.log;
    error_log /var/log/nginx/app_error.log;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php$PHP_VERSION-fpm.sock;
    }
}
EOF

# Activar sitio y desactivar default
sudo ln -sf /etc/nginx/sites-available/myweb /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

# Verificar configuración de Nginx
if sudo nginx -t; then
    sudo systemctl restart php$PHP_VERSION-fpm
    sudo systemctl restart nginx
    sudo systemctl enable nginx
    echo "✓ Nginx configurado y activo"
else
    echo " ERROR: Configuración de Nginx inválida"
    exit 1
fi

# Eliminar ruta NAT y añadir ruta al balanceador
sudo ip route del default 2>/dev/null || true

# sudo mysqldump -p PATRIMONIUM_ALMEIDAE > /vagrant/pa_copia_database.sql

echo "=== Servidor Web configurado ==="