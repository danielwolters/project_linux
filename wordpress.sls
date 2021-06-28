sudo apt install -y software-properties-common:
  cmd.run

php-ppa:
  pkgrepo.managed:
    - ppa: ondrej/php

wordpress en mysql en apache install:
  pkg.installed:
    - names:
      - apache2
      - mysql-server
      - python3
      - php
      - php-mysql
      - php5-fpm
      - python-mysqldb
      - python-pip

php dingetjes:
  cmd.run:
    - name: 'sudo apt install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y'
    - runas: root

mysql-server:
  pkg:
    - installed
    - reload_modules: true

install mysql:
  cmd.run:
    - name: 'sudo apt-get install -y python3-mysqldb'



Database aanmaken:
  mysql_database.present:
    - name: wordpress_database
  mysql_user.present:
    - name: daniel
    - password: P@ssword
  mysql_grants.present:
    - database: "wordpress_database.*"
    - grant: ALL PRIVILEGES
    - user: daniel
    - host: 'localhost'

Wordpress installeren:
  cmd.run:
    - name: 'wget -q -O - http://wordpress.org/latest.tar.gz | tar zxf - '
    - cwd: /var/www
    - creates: /var/www/wordpress/index.php
    - runas: root

htacces file maken:
  cmd.run:
    - name: 'touch /var/www/wordpress/.htaccess'
#    - name: 'mkdir /var/www/wordpress/wp-content/upgrade'
    - runas: root

wordpress config file:
  file.managed:
    - name: /var/www/wordpress/wp-config.php
    - source: salt://configs/wp-config2.php

site meegeven:
  file.managed:
    - name: /etc/apache2/sites-available/daniel.conf
    - source: salt://apa/daniel.conf
    - mode: 777
    - user: root

conf file meegeven:
  file.managed:
    - name: /etc/apache2/sites-available/wordpress.conf
    - source: salt://apa/wordpress.conf

index.php goed zetten:
  file.managed:
    - name: /etc/apache2/mods-available/dir.conf
    - source: salt://apa/dir.conf

commandos:
  cmd.run:
    - names:
      - 'sudo chown -R www-data:www-data /var/www/wordpress'
      - 'sudo find /var/www/wordpress/ -type d -exec chmod 750 {} \;'
      - 'sudo find /var/www/wordpress/ -type f -exec chmod 640 {} \;'
      - 'sudo chmod 755 /var/www/wordpress'
    - runas: root

sites enablen:
  cmd.run:
    - names:
      - 'sudo a2ensite daniel.conf'
      - 'sudo a2dissite 000-default.conf'
      - 'sudo a2enmod rewrite' 
      - 'sudo apache2ctl configtest'
    - runas: root

restart:
  cmd.run:
    - name: 'systemctl restart apache2'
    - runas: root
