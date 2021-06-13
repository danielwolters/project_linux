#! /bin/bash

salt 'minion2' cp.push_dir /etc/nagios_client/ 

cp /var/cache/salt/master/minions/*/files/etc/nagios_client/* /usr/local/nagios/etc/servers

#cp /var/cache/salt/master/minions/*/files/etc/minionCONF.cfg /usr/local/nagios/etc/servers

systemctl restart nagios


