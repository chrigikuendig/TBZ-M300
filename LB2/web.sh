#!/bin/bash

# UFW konfigurieren
echo "y" | sudo ufw enable
sudo ufw allow from 10.0.2.2 to any port 22
sudo ufw allow from 10.0.2.2 to any port http
sudo ufw allow from 10.0.2.2 to any port https
sudo ufw reload

# Apache installieren
sudo apt install apache2 -y

# Apache konfigurieren
sudo a2enmod proxy_http
sudo cat > /etc/apache2/sites-available/000-default.conf << EOL
<VirtualHost *:80>
        ServerName 192.168.115.10
        ProxyPass /webmin http://192.168.115.20:10000/
        ProxyPassReverse /webmin/ http://192.168.115.20:10000/
        Redirect permanent /webmin /webmin/
</VirtualHost>
EOL
sudo systemctl restart apache2
