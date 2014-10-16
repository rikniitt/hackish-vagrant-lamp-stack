#!/usr/bin/env bash

# I use this script to setup my vagrant precise32 dev boxes.
# Someday I hopefully have some other (more robust) script.

# Change this to non-zero if you want to see
# everything outputted during provisioning.
DEBUG=0

function print_header {
  header="=============================================="
  echo ""
  echo "$header"
  echo -e "$1"
  echo "$header"
  echo ""
}


function exec_recipe {
  script="/vagrant/bash_provision/recipes/$1.sh"
  if [ $DEBUG -eq 0 ]; then
    /bin/bash "$script" > /dev/null
  else
    /bin/bash "$script"
  fi
}


print_header "Updating (package indexes)...."
exec_recipe "apt_update"

print_header "Installing some basic packages..."
exec_recipe "basic_packages"

print_header "Installing apache..."
exec_recipe "apache"

print_header "Installing php5..."
exec_recipe "php"

print_header "Installing some php5 extensions..."
exec_recipe "php_extensions"

print_header "Installing mysql..."
exec_recipe "mysql"

print_header "Setting up apache virtual hosts..."
exec_recipe "apache_vhost"

print_header "Creating home/scripts folder and adding it to PATH..."
exec_recipe "home_scripts"

print_header "Download composer..."
exec_recipe "composer"

print_header "Install some global composer packages..."
exec_recipe "composer_packages"

print_header "Downloading and install nodejs \nfrom source (compiling will take a while)..."
exec_recipe "nodejs"

print_header "Install some global nodejs packages..."
exec_recipe "nodejs_packages"


print_header "Hopefully done!!!"
