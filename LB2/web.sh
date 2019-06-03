#!/bin/bash

# UFW konfigurieren

echo "y" | sudo ufw enable
sudo ufw allow from 10.0.2.2 port ssh
sudo ufw allow from 10.0.2.2 port http
sudo ufw allow from 10.0.2.2 port https
sudo ufw allow from 10.0.2.2 port 10000/tcp
sudo ufw reload


# Apache installieren

sudo apt install apache2 -y


# Webmin repo installieren
sudo echo 'deb http://download.webmin.com/download/repository sarge contrib' > /etc/apt/sources.list.d/webmin.list
wget http://www.webmin.com/jcameron-key.asc
sudo apt-key add jcameron-key.asc

#Key-Kopie aus Home-Directory entfernen
rm jcameron-key.asc

# Webmin installieren
sudo apt update
sudo apt install webmin -y

sudo systemctl enable webmin