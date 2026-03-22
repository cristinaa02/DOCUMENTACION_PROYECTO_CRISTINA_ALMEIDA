#!/bin/bash

# variables de entorno
DB_NAME="PATRIMONIUM_ALMEIDAE"
DB_USER="PAdmin"
DB_PASS="PA123"
DB_HOST="192.168.40.%"

# Actualizar el sistema e instalar MariaDB.
sudo apt update
sudo apt install -y mariadb-server

# Configurando MySQL para escuchar en 0.0.0.0.
sudo sed -i "s/^bind-address.*127.0.0.1/bind-address = 0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb

# Creando la BD y usuario.
sudo mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME CHARSET utf8mb4;
CREATE USER '$DB_USER'@'$DB_HOST' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'$DB_HOST' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
echo "Host: $DB_HOST | DB: $DB_NAME | User: $DB_USER | Pass: $DB_PASS"

sudo mysql -u root $DB_NAME < /vagrant/db/pa_database.sql

# Eliminar la puerta de enlace de la NAT
sudo ip route del default

echo "=== Servidor DB configurado ==="