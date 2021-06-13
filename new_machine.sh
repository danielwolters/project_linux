#! /bin/bash

# Install saltstack
add-apt-repository ppa:saltstack/salt -y
apt-get update -y
apt-get install salt-minion -y
apt-get upgrade -y

# Set salt master location and start minion
sed -i 's/#master: salt/master: 10.0.6.54/' /etc/salt/minion
salt-minion -d