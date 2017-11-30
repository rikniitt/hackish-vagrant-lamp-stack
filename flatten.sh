#!/usr/bin/env bash

provision='./bash_provision/provision.sh'
scripts='./bash_provision/recipes'

echo "Reading $provision..."
recipes=$( \
  grep -vxE '[[:blank:]]*([#].*)?' $provision \
   | grep exec_recipe \
   | grep -v function \
   | cut -d '"' -f2 \
)
echo "Going to inline provision scripts:"
echo "  "$recipes

inline=''
while read -r recipe; do
    script=$scripts/$recipe".sh"
    echo "Reading $script"
    if [ -n "$EXCLUDE_COMMENTS" ]; then
        header=''
        lines=$( tail -n +2 $script | grep -v -e '^$' | grep -v '^#' )
    else
        header='### '$recipe$'\n'
        lines=$( tail -n +2 $script | grep -v -e '^$' )
    fi
    inline="$inline$header$lines"$'\n'
done <<< "$recipes"

read -r -d '' vagrant << VAGRANT
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/precise32"

  config.vm.hostname = "lamp-box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Enable provisioning with custom hackish shell script
  config.vm.provision "shell", inline: <<-SHELL
$inline
  SHELL
end

VAGRANT

echo "$vagrant" >> Vagrantfile-flatten
echo "New flattened Vagrantfile 'Vagrantfile-flatten' created."
