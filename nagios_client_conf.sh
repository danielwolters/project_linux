#! /bin/bash


hostnaam=$(hostname)

host_ip=$(hostname -I)


echo $host_ip

echo $hostnaam


cat > /etc/$hostnaam.cfg << EOF 

define host {
	use     linux-server

	host_name	$hostnaam

	alias	$hostnaam

	address		$host_ip

	max_check_attempts 5

	check_period    24x7

	notification_interval   30

	notification_period     24x7

}



define service {

	use     generic-service

	host_name	$hostnaam

	service_description	Loadaverage

	check_command	check_nrpe!check_load

}

define service {

	use    generic-service

	host_name	$hostnaam

	service_description     /dev/vda1 free space

	check_command   check_nrpe!check_vda1

}

EOF

cp /etc/$hostnaam.cfg /etc/nagios_client/$hostnaam.cfg


