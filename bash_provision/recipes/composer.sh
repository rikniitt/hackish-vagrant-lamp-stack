#!/usr/bin/env bash

# Create folder for it
mkdir /home/vagrant/composer
# Download it
cd /home/vagrant/composer && curl -sS https://getcomposer.org/installer | php
# Add it to path
echo "export PATH=\"\$HOME/composer:\$PATH\"" >> /home/vagrant/.bashrc
