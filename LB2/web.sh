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
        ProxyPass /webmin http://localhost:10000/
        ProxyPassReverse /webmin/ http://localhost:10000/
        Redirect permanent /webmin /webmin/
        DocumentRoot /var/www/html
</VirtualHost>
EOL

# Apache HTML-Startseite bearbeiten
sudo rm /var/www/html/index.html
sudo touch /var/www/html/index.html
sudo echo '<!doctype html>' >> /var/www/html/index.html
sudo echo '<title>Test-Seite</title>' >> /var/www/html/index.html
sudo echo '<style>' >> /var/www/html/index.html
sudo echo 'body { text-align: center; padding: 150px; }' >> /var/www/html/index.html
sudo echo 'h1 { font-size: 50px; }' >> /var/www/html/index.html
sudo echo 'body { font: 20px Helvetica, sans-serif; color: #333; }' >> /var/www/html/index.html
sudo echo 'article { display: block; text-align: left; width: 650px; margin: 0 auto; }' >> /var/www/html/index.html
sudo echo 'a { color: #dc8100; text-decoration: none; }' >> /var/www/html/index.html
sudo echo 'a:hover { color: #333; text-decoration: none; }' >> /var/www/html/index.html
sudo echo '</style>' >> /var/www/html/index.html

sudo echo '<article>' >> /var/www/html/index.html
sudo echo '<h1>Dies ist eine Testwebseite!</h1>' >> /var/www/html/index.html
sudo echo '<div>' >> /var/www/html/index.html
sudo echo '<p>Diese Webseite dient nur als Test und als Demonstration, dass auch Der Apache-Webserver erreichbar ist</p>' >> /var/www/html/index.html
sudo echo '<p>&mdash; Christoph Kuendig</p>' >> /var/www/html/index.html
sudo echo '</div>' >> /var/www/html/index.html
sudo echo '</article>' >> /var/www/html/index.html
sudo echo '<pre style="text-align: center; line-height: 0.5">' >> /var/www/html/index.html
sudo echo '      _       _         </br>' >> /var/www/html/index.html
sudo echo '     (_\     /_)        </br>' >> /var/www/html/index.html
sudo echo '       ))   ((          </br>' >> /var/www/html/index.html
sudo echo '     .-"""""""-.        </br>' >> /var/www/html/index.html
sudo echo ' /^\/  _.   _.  \/^\    </br>' >> /var/www/html/index.html
sudo echo ' \(   /__\ /__\   )/    </br>' >> /var/www/html/index.html
sudo echo '  \,  \o_/_\o_/  ,/     </br>' >> /var/www/html/index.html
sudo echo '    \    (_)    /       </br>' >> /var/www/html/index.html
sudo echo '     `-. === .-/        </br>' >> /var/www/html/index.html
sudo echo '      __) - (__         </br>' >> /var/www/html/index.html
sudo echo '     /  `~~~`  \        </br>' >> /var/www/html/index.html
sudo echo '    /  /     \  \       </br>' >> /var/www/html/index.html
sudo echo '    \ :       ; /       </br>' >> /var/www/html/index.html
sudo echo '     \|==(*)==|/        </br>' >> /var/www/html/index.html
sudo echo '      :       :         </br>' >> /var/www/html/index.html
sudo echo '       \  |  /          </br>' >> /var/www/html/index.html
sudo echo '     ___)=|=(___        </br>' >> /var/www/html/index.html
sudo echo '    {____/ \____}       </br>' >> /var/www/html/index.html
sudo echo '</pre>' >> /var/www/html/index.html


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
webprefix=/webmin
webprefixnoredir=1
referers=192.168.115.10
EOL

sudo systemctl restart webmin
sudo systemctl restart apache2
