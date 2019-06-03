# TBZ-M300
TBZ Modul 300: Plattformübergreifende Dienste in ein Netzwerk integrieren.


## Inhalt
* [Vorwissen](##Vorwissen)
* [LBs](##Leistungsbeurteilungen)


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

## Leistungsbeurteilungen
* [LB2](./LB2/readme.md)
* [LB3](./LB3/readme.md)