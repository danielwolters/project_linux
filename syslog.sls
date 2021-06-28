Syslog-ng install en config:
  pkg.installed:
    - names: 
      - syslog-ng
      - lynx
      - apache2
  file.directory:
    - name: /var/www/daniel
    - user: root
    - group: root
    - mode: 755
config file meegeven:
    file.managed:
      - name: /etc/syslog-ng/syslog-ng.conf
      - source: salt://configs/syslog-ng-client.conf
l
restarten van services:
  service.running:
    - names: 
      - syslog-ng
      - apache2
    - reload: True
  

