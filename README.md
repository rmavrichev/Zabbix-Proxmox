Zabbix - Proxmox/QM
==============

Zabbix Template for monitoring cpu(only qty)/memory/network/etc... of your Proxmox/QM Server  
This Template implements *low level discovery* to automatically discover all of your guest systems after you applied the template to a host


### Setup 

* Add the following to your **/etc/zabbix/zabbix_agentd.conf.d/userparameter_proxmox.conf** file.

```
UserParameter=pve.pveversion,/usr/bin/pveversion
UserParameter=pve.pvesubget.all[*],sudo /usr/local/bin/pvesubget.sh | sed -n '/^$1:/p' | sed 's/^$1: //g'
UserParameter=pve.qmlist.running,sudo /usr/local/bin/qmdiscover.sh
UserParameter=pve.qmlist.stopped,sudo /usr/local/bin/qmdiscover.sh
UserParameter=pve.qminfo.all[*],sudo /usr/local/bin/qmstatus.sh $1 -verbose | sed -n '/^$2:/p' | awk '{print $$2}'
UserParameter=pve.stopped.qminfo.all[*],sudo /usr/local/bin/qmstatus.sh $1 -verbose | sed -n '/^$2:/p' | awk '{print $$2}'
```
* Copy the file **pvesubget.sh**  to **/usr/local/bin/pvesubget.sh**  and make it executable
* Copy the file **qmdiscover.sh** to **/usr/local/bin/qmdiscover.sh** and make it executable
* Copy the file **qmstatus.sh**   to **/usr/local/bin/qmstatus.sh**   and make it executable

* Because some scripts could only executed as root, you need to add this line to your visudo list

```
zabbix ALL=NOPASSWD:/usr/local/bin/qmdiscover.sh,/usr/local/bin/qmstatus.sh,/usr/local/bin/pvesubget.sh
```

* Import the Basic_Proxmox_VE_Resources_qm.xml File into your Zabbix
