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
# Create installation and download folders
mkdir /home/vagrant/nodejs
mkdir /home/vagrant/node-latest-install
# Download and extract
cd /home/vagrant/node-latest-install
curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
# Configure, compile and install
./configure --prefix=/home/vagrant/nodejs
make install
curl https://www.npmjs.org/install.sh | sh
# Add node bin to vagrant users path
echo "export PATH=\"\$HOME/nodejs/bin:\$PATH\"" >> /home/vagrant/.bashrc
# Remove download dir
cd /
rm -rf /home/vagrant/node-latest-install
# And finally chown nodejs folder
chown -R vagrant:vagrant /home/vagrant/nodejs
