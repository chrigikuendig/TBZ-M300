# LB2

## Inhalt
* [Vorwissen](##Vorwissen)
* [Dokumentation](##Dokumentation)
* [Reflexion](##Reflexion)
## Vorwissen

### Linux
Linux ist eine Betriebssystem-"Familie", welche alle auf dem quelloffenen Linux-Kernel basieren. Die eigentlichen Betriebssysteme werden Distributionen genannt. Davon gibt es unzählige Verschiedene. Die Bekanntesten sind zum Beispiel Ubuntu und Debian. Da der Linux-Kernel ein Open-Source-Projekt ist kann jede Person den Quellcode einsehen und verändern. Darum gibt es auch so viele verschiedene Linux-Distributionen. Diese sind oftmals auch für verschiedene Anwendungszwecke angepasst, wie zum Beispiel Kali für "Penetration Testing" und "Hacking" angepasst ist.
  
Mit Linux kenne ich mich einigermassen gut aus. Ich habe bereits verschiedene Serverdienste vor allem auf Ubuntu-Servern installiert. Ausserdem komme ich mit bash-Scripts gut zurecht. Da ich nicht täglich mit Linux arbeite, würde ich mich noch nicht als Linux-Profi bezeichnen, da ich vieles noch nachschlagen muss.

### Virtualisierung
Durch Virtualisierung lassen sich mehrere virtuelle Maschinen auf einem Host gleichzeitig betreiben. Den virtuellen Maschinen wird die Hardware vom Host entweder direkt auf Hardwareebene bereitgestellt oder durch das auf dem Host installierte Betriebssystem bereitgestellt.
  
Ich kenne mich bereits mit verschiedenen Virtualisierungssystemen aus. Am besten kenne ich mich mit den Virtualisierungslösungen von vmWare aus. Mit Oracle VirtualBox habe ich auch bereits eine virtuellen Maschinen betrieben. Mit Hyper-V habe ich noch am wenigsten Erfahrung.

### Vagrant
Mit Vagrant lassen sich virtuelle Maschinen über die Kommandozeile erstellen verwalten und löschen. Der Vorteil an Vagrant ist, dass sich beim Erstellen von VMs auch Serverdienste und andere Anwendungen - alles, was über die Kommandozeile möglich ist - installieren lassen. Da alles über die Kommandozeile läuft, lassen sich viele Abläufe durch Scripts automatisieren. Die VM wird bei Vagrant durch ein Vagrantfile definiert. Dort drin steht, welche Hardware der VM zugeordnet wird und welche Befehle in der VM ausgeführt werden.
  
Vor dem Modul 300 kannte ich Vagrant noch nicht. Das Feld der Automatisierung von VMs ist für mich komplettes Neuland. Ich finde es aber jedoch sehr interessant, wie weit man gehen kann, im Bereich der Automatisierung.

Hier noch ein paar Befehle und deren Erklärung:  

| Befehl | Erklärung |
| --- | --- |
| `vagrant up` | Startet die im Vagrantfile definierte VM mit allen im Vagrantfile definieten Befehlen |
| `vagrant halt` | Stoppen der VM |
| `vagrant destroy` | Zerstören der VM |
| `vagrant reload` | Neustart der VM mit aktuellem Vagrantfile |
| `vagrant status` | Anzeigen des Status der VM |
| `vagrant ssh-config` | Anzeigen der SSH-Konfiguration der VM |
  
### Versionverwaltung / Git
Github lässt sich hervorragend zur Versionsverwaltung und Dokumentation von Projekten verwenden. Dateien können lokal angepasst werden, dann durch Stagen, "Commit" und "Push" auf github hochgeladen wird. Für jeden Commit wird ein Kommentar angegeben, um die Änderungen nachzuverfolgen.
  
Mit Github kenne ich mich nur soweit aus, dass auch schon Software auf github heruntergeladen habe. Selber habe ich github zur Versionsverwaltung noch nie benutzt. Darum musste ich zuerst github kennenlernen, bevor ich in diesem Modul etwas beginnen konnte.

### Markdown
Markdown ist laut Wikipedia eine Auszeichnungssprache. Damit lassen sich Texte darstellen und mit einfachem Syntax formatieren:
  
| Befehl | Erklärung |
| --- | --- |
| `# Titel` | Formatierung eines Titels. Je mehr "#", desto kleiner der Titel (Untertitel) |
| ``code`` | Formatierung als Code |
| `- [ ] Checkliste` | Formatierung als Checkliste |
  
Auch Markdown ist für mich komplettes Neuland, aber dank dem einfachen Syntax nicht schwer zu erlernen.

### Systemsicherheit

#### Reverse Proxy
Der Reverse Proxy verschleiert gegenüber dem Client, von welchem Server er die Daten holt.

#### Uncomplicated Firewall
UFW ist eine vereinfachte Hostfirewall für Linux. Damit lassen sich mit einfachen Befehle Ports öffnen und schliessen.
  
| Befehl | Erklärung |
| --- | --- |
| `ufw allow from 10.0.0.10 to any port 22` | SSH nur von Host 10.0.0.10 erlauben |
| `sudo ufw sudo numbered` | Anzeigen der Firewallrules |
| `sudo ufw delete 1` | Löschen der 1. Firewallrule |
| `sudo ufw reload` | Aktualisieren der FW-Rules |

## Dokumentation 

- [Vagrantfile](/LB2/vagrantfile)
- [Shell-Script](/LB2/web.sh)

### Idee
Meine Idee ist es, einen Apache Webserver automatisiert aufzusetzen. Zusätzlich soll Webmin, ein Monitoring-Webinterface, installiert werden und mittels Reverse Proxy unter derselben Adresse wie der Apache Webserver, aber unter einem separaten Pfad, bereitzustellen.  

### Durchführung
Reverse Proxy, Apache Webserver und Webmin befinden sich alle auf demselben Host. Damit aber keine Ports für Webmin in der URL angegeben werden müssen, wird Webmin über einen Reverse Proxy auf die Adresse `localhost/webmin` gemappt. Dies geht mit den Einträgen `ProxyPass` & `ProxyPassReserve` im File `/etc/apache2/sites-available/000-default.conf`.

### Netzwerkplan
Netzwerktechnisch sieht das Ganze wie folgt aus:  
```
+---------------------------------------------+
| +-----------------------------------------+ |
| |                                         | |
| |                                         | |
| |                 Internet                | |
| |                                         | |
| |                                         | |
| +--------------------+--------------------+ |
|                      |   Port 80 TCP        |
| +--------------------+--------------------+ |
| |                                         | |
| |              Reverse Proxy              | |
| |              192.168.115.10             | |
| |                                         | |
| +--------------------+--------------------+ |
| Erreichbar          / \       Erreichbar    |
| unter /            /   \      unter /webmin |
| +------------------+   +------------------+ |
| |                  |   |                  | |
| | Apache Webserver |   | Webmin           | |
| | Port 80 TCP      |   | Port 10000 TCP   | |
| |                  |   |                  | |
| +------------------+   +------------------+ |
+---------------------------------------------+
```

### Konfiguration Reverse Proxy
Diese Änderungen sind in der Datei `/etc/apache2/sites-available/000-default.conf` vorzunehmen:  
```
<VirtualHost *:80>
        ServerName 192.168.115.10
        ProxyPass /webmin http://localhost:10000/
        ProxyPassReverse /webmin/ http://localhost:10000/
        Redirect permanent /webmin /webmin/
</VirtualHost>
```

### Konfiguration Webmin
In der Datei `/etc/webmin/miniserv.conf` wurden folgende Änderungen vorgenommen:  
```
ssl=0
```  

An die Datei `/etc/webmin/config` müssen folgende Argumente angehängt werden:
```
webprefix=/webmin
webprefixnoredir=1
referers=192.168.115.10
```

### Konfiguration Firewall
In der Host Firewall sind nur die Ports für SSH (22/TCP), HTTP (80/TCP) und HTTPS (443/TCP) freigegeben.

## Testing
- [ ] Testfall 1: Webmin ist über `localhost/webmin` erreichbar  
    ![alt text](/LB2/testfall1.png "Testfall 1")
- [ ] Testfall 2: Server gibt keine Antwort unter `localhost:10000`  
    ![alt text](/LB2/testfall2.png "Testfall 2")

## Reflexion
Anfangs gab mir VirtualBox die Fehlermeldung, dass VT-x auf meinem Laptop nicht aktiviert war, obwohl dies laut Task-manager und BIOS aktiviert war. Dieses Problem konnte ich dann schlussendlich lösen, in dem ich VT-x kurz deaktiviert habe und danach wieder neu aktiviert habe. Danach konnte ich VMs wieder starten.  
Da ich mich mit Reverse Proxy noch nicht auskannte, konnte ich diese Arbeit nicht einfach aus dem Ärmel schütteln. Es war jedoch sehr interessant, meinen Wissenstand zu erweitern.