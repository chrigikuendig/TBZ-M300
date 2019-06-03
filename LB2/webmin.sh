#!/bin/bash

# UFW konfigurieren
echo "y" | sudo ufw enable
sudo ufw allow from 10.0.2.2 to any port 22
sudo ufw allow from 10.0.2.2 to any port 10000
sudo ufw reload


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

# webmin konfigurieren
sudo sed -i -E "s/(ssl=)(1)/\10/" /etc/webmin/miniserv.conf
sudo cat >> /etc/webmin/config << EOL
ebprefix=/webmin
webprefixnoredir=1
referers=192.168.115.10
EOL

sudo systemctl restart webmin
