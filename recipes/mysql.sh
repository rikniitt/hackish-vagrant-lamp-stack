#!/usr/bin/env bash

MYSQL_ROOT_PASSWORD="secret"

# Some magic to get rid of mysql root password prompt
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql
# Create mysql conf file for user
touch /home/vagrant/.my.cnf
cat > /home/vagrant/.my.cnf <<EOL
[mysql]
user = root
password = ${MYSQL_ROOT_PASSWORD}
pager = less
show-warnings
EOL

