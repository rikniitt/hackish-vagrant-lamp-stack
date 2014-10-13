#!/usr/bin/env bash

# I use this script to setup my vagrant precise32 dev boxes.
# Someday I hopefully have some other (more robust) script.

MYSQL_ROOT_PASSWORD="secret"

header=" =========== "


echo ""
echo "$header Updating (package indexes)...."
sudo apt-get -y update


echo ""
echo "$header Installing some basic packages..."
sudo apt-get -y install curl screen git tree


echo ""
echo "$header Installing apache..."
sudo apt-get -y install apache2
# Get rid of "Could not reliably determine..."
echo ServerName $HOSTNAME >> /etc/apache2/apache2.conf


echo ""
echo "$header Installing php5..."
sudo apt-get -y install libapache2-mod-php5


echo ""
echo "$header Installing mysql..."
# Some magic to get rid of mysql root password prompt
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
sudo apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql


echo ""
echo "$header Installing some php5 extensions..."
sudo apt-get -y install php5-curl php5-mcrypt


echo ""
echo "$header Setting up apache virtual hosts..."
# Create new folder to shared folder.
sudo mkdir /vagrant/public_html
# Copy default apache virtual host conf.
sudo cp /etc/apache2/sites-available/default /etc/apache2/sites-available/vagrant-default
# Use sed to change default /var/www to point new created dir
sudo sed -i -e 's/var\/www/vagrant\/public_html/g' /etc/apache2/sites-available/vagrant-default
# Enable and disable virtual hosts
sudo a2dissite default && sudo a2ensite vagrant-default && sudo service apache2 reload
# Create some basic index file
sudo echo "<h1>Hello vagrant</h1>" >> /vagrant/public_html/index.php
sudo echo "<?php echo '<h2>Hello from php also</h2>'; ?>" >> /vagrant/public_html/index.php



echo ""
echo "$header"
echo "$header Hopefully done!!!"
echo "$header"
