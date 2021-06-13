Syslog-ng install en config:
  pkg.installed:
    - name: syslog-ng
    - name: lynx
    - name: apache2
  file.directory:
    - name: /var/www/daniel
    - user: root
    - group: root
    - mode: 755
File 1:
  file.managed:
      - name: /etc/apache2/sites-available/daniel.conf
      - source: salt://apa/daniel.conf
File 2:
    file.managed:
      - name: /etc/syslog-ng/syslog-ng.conf
      - source: salt://configs/syslog-ng-client.conf
File 3:
    file.managed:
      - name: /etc/apache2/sites-enabled/daniel.conf
      - source: salt://apa/daniel.conf
File 4:
    file.managed:
      - name: /var/www/daniel/index.html
      - source: salt://apa/index.html
    service.running:
      - names: 
        - syslog-ng
        - apache2
      - reload: True
  

