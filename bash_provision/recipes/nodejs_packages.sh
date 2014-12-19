#!/usr/bin/env bash

# Add installation folder to path (the hard way) for this provision script
# http://stackoverflow.com/questions/21687789/updating-path-in-vagrant-using-shell-provisioning
echo PATH $PATH
[ -f ~/.profile ] || touch ~/.profile
[ -f ~/.bash_profile ] || touch ~/.bash_profile
grep 'PATH=/home/vagrant/nodejs/bin' ~/.profile || echo 'export PATH=/home/vagrant/nodejs/bin:$PATH' | tee -a ~/.profile
grep 'PATH=/home/vagrant/nodejs/bin' ~/.bash_profile || echo 'export PATH=/home/vagrant/nodejs/bin:$PATH' | tee -a ~/.bash_profile
. ~/.profile
. ~/.bash_profile
echo PATH $PATH

# And use npm to install packages
npm install -g grunt-cli
npm install -g bower
npm install -g yo
npm install -g generator-webapp
npm install -g generator-bootstrap
npm install -g generator-angular
npm install -g generator-backbone
npm install -g generator-marionette-frontend
