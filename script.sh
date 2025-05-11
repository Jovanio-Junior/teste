#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install squid -y

sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.bkp

# Substitui a configuração por uma básica e aberta
sudo bash -c 'cat > /etc/squid/squid.conf' <<EOF
http_port 3128
acl all src 0.0.0.0/0
http_access allow all
EOF

# Abre a porta 3128 no firewall (caso UFW esteja ativo)
if sudo ufw status | grep -q "Status: active"; then
    sudo ufw allow 3128/tcp
fi

sudo systemctl restart squid

sudo systemctl enable squid
