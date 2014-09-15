#!/usr/bin/env bash

### 
# I use this script to setup my vagrant precise32 dev boxes.
# Someday I hopefully have some other (more robust) script.

header=" ### ### "

echo "$header Updating and upgrading...."
sudo apt-get update
sudo apt-get upgrade


echo "$header Installing some basic packages..."
sudo apt-get install curl screen git


echo "$header Installing apache..."
sudo apt-get install apache2


echo "$header Installing php5..."
sudo apt-get install libapache2-mod-php5


echo "$header Installing mysql... (will probably prompt for root passwd)"
sudo apt-get install mysql-server libapache2-mod-auth-mysql php5-mysql


echo "$header Installing some php5 extensions"
sudo apt-get install php5-curl php5-mcrypt


echo "$header"
echo "$header Hopefully done!!!"
echo "$header"
