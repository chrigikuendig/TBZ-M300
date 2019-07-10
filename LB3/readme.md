# LB3


## Inhalt
- [LB3](#lb3)
  - [Inhalt](#inhalt)
  - [Vorwissen](#vorwissen)
    - [Containerisierung](#containerisierung)
      - [Wichtige Docker-Befehle](#wichtige-docker-befehle)
    - [Microservices](#microservices)
  - [Vorbereitung](#vorbereitung)
  - [Dokumentation](#dokumentation)
    - [Idee](#idee)
    - [Durchführung](#durchf%C3%BChrung)
  - [Reflexion](#reflexion)

## Vorwissen

### Containerisierung
Container sind heutzutage ein wichtiges Thema. Viele Firmen setzen bereits Container ein wie zum Beispiel Google, welche für jede Gmail-Sitzung einen neuen Container erstellt. Container sind ähnlich wie virtuelle Maschinen. Sie sind jedoch nicht vollständig vom Host isoliert wie die VMs. Der Kernel des Hostbetriebssystem wird mit dem Container geteilt, jedoch einzelne OS-Komponenten werden isoliert. Ein grosser Vorteil ist hierbei, dass die Container sehr schnell gestartet werden können, und dass weniger Overhead generiert wird.  

Mit speziellen Software wie Docker lassen sich solche Container rasch bereitstellen. Für viele verschiedene Dienste findet man auf dem Docker-Hub bereits vorgefertigte Docker-Container, welche nur noch mittels einem Dockerfile gestartet werden müssen. In diesem Dockerfile können Anpassungen am Dienst aber auch am Container selber gemacht werden (Netzwerkkonfiguraiton etc.)

#### Wichtige Docker-Befehle
| Befehl | Erklärung |
| --- | --- |
| `docker run` | Startet einen Container |
| `docker exec` | Zugriff auf Container über Kommandozeile ("Docker-SSH") |
| `docker ps` | Anzeigen aller laufenden Docker-Container |
| `docker stop` | Stoppen eines Docker-Container über Namen oder ID |
| `docker-compose up/down` | Start/Stop von Docker-Compose-Umgebungen |
| `docker rm` | Löschen eines Containers |
| `docker pull` | Herunterladen eines Docker-Images |
### Microservices
Als Microservice bezeichnet man Teile einer Applikation, welche nur ein sehr kleiner Teil dieser Applikation übernehmen. Diese Microservices sind voneinander unabhängige Prozesse. Der Vorteil von Microservices ist die Skalierbarkeit. Braucht es von einem Service innerhalb einer Applikation aufs Mal mehr, dann können problemlos weitere Instanzen dieses Microservices gestartet werden. Beim Beispiel einer Webseite ist zum Beispiel die Startseite ein Microservice, die Login-Maske ein weiterer Microservice, usw.
## Vorbereitung
Als erstes muss die Vagrant-VM mit der Docker-Umgebung gestartet & verbunden werden:  
```
    cd /M300/docker
    vagrant up
    vagrant ssh
```
Danach kann docker installiert werden:  
```
    sudo dpkg --configure -a
    sudo apt install docker
```
## Dokumentation
### Idee
Meine Idee war, da ich keine Erfahrungen mit Docker habe, etwas simples zu erstellen, was schlussendlich dann aber sicher funktioniert. Deshalb habe ich mich entschieden, nur einen nginx-Webserver auf Port 80 aufzusetzen.
### Durchführung
Verzeichnis für Docker-Container erstellen:  
```
    mkdir nginx
```

Docker-Image für nginx vom Docker-Hub herunterladen:
```
    sudo docker pull nginx
```

Dockerfile für die Konfiguration von nginx erstellen:
```
    touch Dockerfile
    sudo nano Dockerfile
    FROM nginx
    COPY static-html-directory /usr/share/nginx/html
    EXPOSE 80
```

Docker-Container builden:
```
    sudo docker build -t some-content-nginx .
```

Docker-Container starten:
```
    sudo docker run --name some-nginx -d some-content-nginx
```
## Reflexion
Ich habe den Zeitaufwand leider sehr unterschätzt. Ich habe mir zuerst viel vorgenommen, doch dann ist mir die Zeit davon gelaufen. Da ich mit Docker auch noch keine Erfahrungen hatte musste ich mich zuerst noch im Thema einlesen. Dies gestaltete sich auch nicht ganz einfach. Da für mich diese automatisierte Form der Virtualisierung generell sehr neu ist, brauchte ich länger als erwartet, um alles zu verstehen.