# os2openclient
Standards based Linux configuration management, OS deployment and monitoring.

#### Executive summary in Danish 🇩🇰:
*Vi arbejder på at skabe en simpel, standardiseret og åben platform, der gør det nemt at implementere, administrere og overvåge applikationer. Vores projekt er baseret på et åbent operativsystem og bruger kendte standard værktøjer til at sikre en problemfri drift. Formålet er at tjene som det grundlæggende system for forskellige løsninger, såsom digitale skilte og offentlige tilgængelige internet pcere.*

## Architecture proposal

### Cornerstone backend components:
- Secure Push based device management & Automation - [Ansible](https://www.ansible.com/overview/how-ansible-works)
- Operating systems deployment  - [netboot.xyz](https://netboot.xyz/docs)
- Obeservability and notifications - [Promtail-Loki-Grafana](https://grafana.com/oss/loki/) - MQTT datasource + Grafana could be a simpler alternative, requires a mqtt client instead of a promtail client.

### Clients
- debian for arm and x64 devices
- SSH enabled for secure clientless managment
- promtail client for logging
- Ready to support Apps and services from e.g. os2display, os2borgerpc or other projects running apps on devices. 

```mermaid

graph RL

subgraph management
end

subgraph NUC
debarm(OS2OpenClient debian_x64)-.-
app2(App) & promtail1(log push - promtail)
end


subgraph RPi
debx64(OS2OpenClient debian_armx64)-.-
app1(App) & promtail2(log push - promtail)
end

subgraph Backend
logengine(Logs and notifications loki-Grafana);
configman(Konfiguration ansible);
netboot(Deploy netboot.xyz);
semaphore(ManagementUI- ansible-semaphore);
end

configman-.-netboot
management<--HTTP-->semaphore & logengine
configman--SSH-->RPi & NUC
netboot--TFTP-->RPi & NUC
semaphore-.-configman
logengine-.HTTP.-RPi & NUC

```
