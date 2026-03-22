#!/bin/bash

sudo apt update
# Instalar iptables-persistent
sudo DEBIAN_FRONTEND=noninteractive apt install -y iptables-persistent netfilter-persistent

# Habilitar el reenvío de paquetes (IP Forwarding)
sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sudo sysctl -p
echo "Modificado el archivo /etc/sysctl.conf y aplicado IP Forwarding."

# Ruta para llegar a los Web Servers a través del balanceador
sudo ip route add 192.168.30.0/24 via 192.168.20.10

# Limpiar reglas
sudo iptables -F
sudo iptables -t nat -F

# Obliga al Balanceador a responder a través del Router
sudo iptables -t nat -A POSTROUTING -p tcp -d 192.168.20.10 -j MASQUERADE

# Asegurar que el router permita pasar paquetes entre interfaces.
sudo iptables -P FORWARD ACCEPT 
sudo iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Reglas de NAT (Entrada: Internet -> Balanceador)
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.20.10:80
sudo iptables -t nat -A PREROUTING -p tcp --dport 82 -j DNAT --to-destination 192.168.20.10:82
sudo iptables -t nat -A PREROUTING -p tcp --dport 443 -j DNAT --to-destination 192.168.20.10:443

# Reglas de NAT (Salida: Redes Internas -> Internet)
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

sudo netfilter-persistent save
echo "Router configurado."