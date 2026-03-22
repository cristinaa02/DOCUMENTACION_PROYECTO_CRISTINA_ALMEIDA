#!/bin/bash

# Actualizar e instalar
sudo apt update
sudo apt install -y vsftpd db-util ufw

# Estructura de directorios
sudo mkdir -p /FTP_Patrimonium/Area_Conservacion/{Fotos,Informes_Restauracion}
sudo mkdir -p /FTP_Patrimonium/Marketing_Media/{Proyectos,Recursos_Graficos}
sudo mkdir -p /FTP_Patrimonium/PUB/{Manuales,Seguridad_prl,Plantillas}

sudo groupadd conservacion
sudo groupadd marketing
# sudo groupadd empleados

# Crear usuarios
sudo useradd -M -g conservacion -s /usr/sbin/nologin -d /FTP_Patrimonium/Area_Conservacion tecnico
echo "tecnico:pass123" | sudo chpasswd

sudo useradd -M -g marketing -s /usr/sbin/nologin -d /FTP_Patrimonium/Marketing_Media marketing
echo "marketing:pass456" | sudo chpasswd

if ! grep -q "/usr/sbin/nologin" /etc/shells; then
    echo "/usr/sbin/nologin" | sudo tee -a /etc/shells
fi

# Permisos
sudo chown root:root /FTP_Patrimonium
sudo chmod 755 /FTP_Patrimonium

sudo chown -R root:conservacion /FTP_Patrimonium/Area_Conservacion
sudo chown -R root:marketing /FTP_Patrimonium/Marketing_Media
sudo chown -R ftp:ftp /FTP_Patrimonium/PUB

sudo chmod 750 /FTP_Patrimonium/Area_Conservacion
sudo chmod 770 /FTP_Patrimonium/Marketing_Media
sudo chmod 555 /FTP_Patrimonium/PUB

# CONFIGURACIÓN VSFTPD
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.backup
sudo tee /etc/vsftpd.conf << EOF_FTP
listen=NO
listen_ipv6=YES
anonymous_enable=YES
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
ftpd_banner="Bienvenido a FTP Patrimonium Almedae"

# Encerrar a todos los usuarios en su home
chroot_local_user=YES
allow_writeable_chroot=YES

# Rutas anónimas
anon_root=/FTP_Patrimonium/PUB
no_anon_password=YES
anon_upload_enable=NO

# Puertos Pasivos para evitar Timeouts
pasv_enable=YES
pasv_min_port=40000
pasv_max_port=40050

secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
EOF_FTP

sudo systemctl restart vsftpd

sudo ufw allow ssh
sudo ufw allow 20/tcp
sudo ufw allow 21/tcp
sudo ufw allow 40000:40050/tcp
sudo ufw enable