#!/usr/bin/env bash

apt-get -y install apache2
# Get rid of "Could not reliably determine..."
echo ServerName $HOSTNAME >> /etc/apache2/apache2.conf
# enable mod_rewrite
a2enmod rewrite
service apache2 restart
