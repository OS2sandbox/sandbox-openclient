# os2openclient
Linux configuration management, OS deployment and monitoring.

## Architecture proposal

### Cornerstone backend components:
- Secure Push based device management & Automation - [Ansible](https://www.ansible.com/overview/how-ansible-works)
- Operating systems deployment  - [netboot.xyz](https://netboot.xyz/docs)
- Obeservability and notifications - [Promtail-Loki-Grafana](https://grafana.com/oss/loki/)

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
app2(Chromium browser kiosk_mode)
end


subgraph RPi
debx64(OS2OpenClient debian_armx64)-.-
app1(Chromium browser kiosk_mode)
end

subgraph Backend
logengine(Logs and notifications promtail-loki-Grafana)
configman(Konfiguration github.com/ansible);
netboot(Deploy github.com/netboot.xyz);
semaphore(ManagementUI- ansible-semaphore);
end

configman-.-netboot
management<--HTTP-->semaphore & logengine
configman--SSH-->RPi & NUC
netboot--TFTP-->RPi & NUC
semaphore & logengine-.-configman


```
