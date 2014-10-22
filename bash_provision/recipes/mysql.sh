#!/usr/bin/env bash

MYSQL_ROOT_PASSWORD="secret"

# Some magic to get rid of mysql root password prompt
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
# Install the server with php modules
apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql


# Try to fix utf8 problems by setting utf8 as default charset
# Archive original mysql config
cp /etc/mysql/my.cnf /etc/mysql/my.cnf.old
# Create temp conf for editing
cp /etc/mysql/my.cnf /etc/mysql/my.cnf.edit
# Add following to mysql conf:
# [mysqld]
# character-set-server=utf8
# collation-server=utf8_general_ci
# init-connect='SET NAMES utf8'
sed -e "s/\[mysqld\]/\[mysqld\]\ncharacter-set-server=utf8\ncollation-server=utf8_general_ci\ninit-connect='SET NAMES utf8'\n/g" < /etc/mysql/my.cnf.edit > /etc/mysql/my.cnf
# Recreate temp conf for editing
cp /etc/mysql/my.cnf /etc/mysql/my.cnf.edit
# Add following to mysql conf:
# [client]
# default-character-set=utf8
sed -e "s/\[client\]/\[client\]\ndefault-character-set=utf8\n/g" < /etc/mysql/my.cnf.edit > /etc/mysql/my.cnf
# Remove temp conf file
rm /etc/mysql/my.cnf.edit


# Restart mysql and apache
service mysql restart
service apache2 restart


# Create mysql conf file for user
touch /home/vagrant/.my.cnf
cat > /home/vagrant/.my.cnf <<EOL
[mysql]
character-sets-dir       = /usr/share/mysql/charsets
default-character-set    = utf8

user                     = root
password                 = ${MYSQL_ROOT_PASSWORD}
pager                    = less
show-warnings

[mysqladmin]
character-sets-dir       = /usr/share/mysql/charsets
default-character-set    = utf8

[mysqlcheck]
character-sets-dir       = /usr/share/mysql/charsets
default-character-set    = utf8

[mysqldump]
character-sets-dir       = /usr/share/mysql/charsets
default-character-set    = utf8

[mysqlimport]
character-sets-dir       = /usr/share/mysql/charsets
default-character-set    = utf8

[mysqlshow]
character-sets-dir       = /usr/share/mysql/charsets
default-character-set    = utf8

EOL
# Change owner
chown vagrant:vagrant /home/vagrant/.my.cnf
