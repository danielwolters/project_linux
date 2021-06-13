Nagios install en configs:
  file.managed:
    - template: jinja
    - name: /etc/{{ grains.id }}.cfg
maak dir:
  file.directory:
    - name: /etc/nagios_client
script:
  file.managed:
    - name: /tmp/nagios_client_conf.sh
    - source: salt://scripts/nagios_client_conf.sh
    - mode: 755
  cmd.run:
    - name: /tmp/nagios_client_conf.sh
    
 
