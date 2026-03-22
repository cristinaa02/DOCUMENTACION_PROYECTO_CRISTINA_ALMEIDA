#!/bin/bash

WEB1_IP="192.168.30.20"
WEB2_IP="192.168.30.21"

# Instalar Nginx
sudo apt update
sudo apt install -y nginx

# Crear certificado para HTTPS
# https://josejuansanchez.org/iaw/practica-01-04/index.html#creaci%C3%B3n-del-certificado-autofirmado
set -x

# Variables con los datos que necesita el certificado
OPENSSL_COUNTRY="US"
OPENSSL_PROVINCE="California"
OPENSSL_LOCALITY="Atherton"
OPENSSL_ORGANIZATION="Patrimonium Almeidae"
OPENSSL_ORGUNIT="Departamento de Informatica"
OPENSSL_COMMON_NAME="publica.patrimoniumalmeidae.com"

sudo openssl req \
  -x509 \
  -nodes \
  -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out /etc/ssl/certs/nginx-selfsigned.crt \
  -subj "/C=$OPENSSL_COUNTRY/ST=$OPENSSL_PROVINCE/L=$OPENSSL_LOCALITY/O=$OPENSSL_ORGANIZATION/OU=$OPENSSL_ORGUNIT/CN=$OPENSSL_COMMON_NAME"


# Config balanceador
sudo tee /etc/nginx/conf.d/load-balancer.conf << EOF
upstream backend_servers {
    server $WEB1_IP:80;
    server $WEB2_IP:80;
}

upstream backend_private_servers {
    server $WEB1_IP:82;
    server $WEB2_IP:82;
}

server {
    listen 443 ssl;
    server_name publica.patrimoniumalmeidae.com;

    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    
    location / {
        proxy_pass http://backend_servers;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
    }
}


server {
    listen 80;
    server_name publica.patrimoniumalmeidae.com;
    
    return 301 https://\$host\$request_uri; # Redirige HTTP a HTTPS

    # location / {
    #     proxy_pass http://backend_servers;
    #     proxy_set_header Host \$host;
    #     proxy_set_header X-Real-IP \$remote_addr;
    #     proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    #     proxy_set_header X-Forwarded-Proto \$scheme;
    # }
}

server {
    listen 82;
    server_name privada.patrimoniumalmeidae.com;
    
    location / {
        proxy_pass http://backend_private_servers;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

sudo rm -f /etc/nginx/sites-enabled/default
sudo systemctl restart nginx

# Eliminar NAT y añadir IP del router
sudo ip route del default 2>/dev/null
sudo ip route add default via 192.168.20.1