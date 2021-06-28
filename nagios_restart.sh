#! /bin/bash

cp /var/cache/salt/master/minions/*/files/etc/nagios_client/* /usr/local/nagios/etc/servers

systemctl restart nagios


