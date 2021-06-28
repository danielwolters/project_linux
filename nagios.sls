Map maken:
  file.directory:
    - name: /etc/nagios_client
Script voor configfile:
  file.managed:
    - name: /tmp/nagios_client_conf.sh
    - source: salt://scripts/nagios_client_conf.sh
    - mode: 755
  cmd.run:
    - name: /tmp/nagios_client_conf.sh
    
 
