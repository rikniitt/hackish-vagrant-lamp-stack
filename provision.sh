#!/usr/bin/env bash

# I use this script to setup my vagrant precise32 dev boxes.
# Someday I hopefully have some other (more robust) script.

function print_header {
  header="=============================================="

  echo ""
  echo "$header"
  echo -e "$1"
  echo "$header"
  echo ""

}


print_header "Updating (package indexes)...."
/vagrant/recipes/apt_update.sh


print_header "Installing some basic packages..."
/vagrant/recipes/basic_packages.sh


print_header "Installing apache..."
/vagrant/recipes/apache.sh


print_header "Installing php5..."
/vagrant/recipes/php.sh


print_header "Installing some php5 extensions..."
/vagrant/recipes/php_extensions.sh


print_header "Installing mysql..."
/vagrant/recipes/mysql.sh


print_header "Setting up apache virtual hosts..."
/vagrant/recipes/apache_vhost.sh


print_header "Creating home/scripts folder and adding it to PATH..."
/vagrant/recipes/home_scripts.sh


print_header "Download composer..."
/vagrant/recipes/composer.sh


print_header "Install some global composer packages..."
/vagrant/recipes/composer_packages.sh


print_header "Downloading and install nodejs \nfrom source (compiling will take a while)..."
/vagrant/recipes/nodejs.sh


print_header "Install some global nodejs packages..."
/vagrant/recipes/nodejs_packages.sh



print_header "Hopefully done!!!"
