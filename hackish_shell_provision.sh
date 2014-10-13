#!/usr/bin/env bash

# I use this script to setup my vagrant precise32 dev boxes.
# Someday I hopefully have some other (more robust) script.

MYSQL_ROOT_PASSWORD="secret"

header=" =========== "


echo ""
echo "$header Updating (package indexes)...."
apt-get -y update


echo ""
echo "$header Installing some basic packages..."
apt-get -y install curl screen git tree python-software-properties python build-essential


echo ""
echo "$header Installing apache..."
apt-get -y install apache2
# Get rid of "Could not reliably determine..."
echo ServerName $HOSTNAME >> /etc/apache2/apache2.conf


echo ""
echo "$header Installing php5..."
apt-get -y install libapache2-mod-php5


echo ""
echo "$header Installing mysql..."
# Some magic to get rid of mysql root password prompt
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql
# Create mysql conf file for user
touch /home/vagrant/.my.cnf
cat > /home/vagrant/.my.cnf <<EOL
[mysql]
user = root
password = ${MYSQL_ROOT_PASSWORD}
pager = less
show-warnings
EOL


echo ""
echo "$header Installing some php5 extensions..."
apt-get -y install php5-curl php5-mcrypt


echo ""
echo "$header Setting up apache virtual hosts..."
# Create new folder to shared folder.
mkdir /vagrant/public_html
# Copy default apache virtual host conf.
cp /etc/apache2/sites-available/default /etc/apache2/sites-available/vagrant-default
# Use sed to change default /var/www to point new created dir
sed -i -e 's/var\/www/vagrant\/public_html/g' /etc/apache2/sites-available/vagrant-default
# Enable and disable virtual hosts
a2dissite default && sudo a2ensite vagrant-default && sudo service apache2 reload
# Create some basic index file
touch /vagrant/public_html/index.php
cat > /vagrant/public_html/index.php <<EOL
<h1>Hello vagrant</h1>
<?php echo '<h2>Hello from php also</h2>'; ?>
EOL


echo ""
echo "$header Creating home/scripts folder and adding it to PATH..."
# Create new folder in home dir
mkdir /home/vagrant/scripts
# Add it to path
echo "export PATH=\"\$HOME/scripts:\$PATH\"" >> /home/vagrant/.bashrc
# Create some helper script in it
touch /home/vagrant/scripts/mysql_console
cat > /home/vagrant/scripts/mysql_console <<EOL
#!/usr/bin/env bash
mysql -uroot -p${MYSQL_ROOT_PASSWORD} --show-warnings
EOL
chmod +x /home/vagrant/scripts/mysql_console


echo ""
echo "$header Downloading composer, some packages and adding them to PATH..."
# Create folder for it
mkdir /home/vagrant/composer
# Download it
cd /home/vagrant/composer && curl -sS https://getcomposer.org/installer | php
# Add composer.json
touch /home/vagrant/composer/composer.json
cat > /home/vagrant/composer/composer.json <<EOL
{
    "name": "vagrant/composer",
    "require": {
        "phpunit/phpunit": "~4.3",
        "phing/phing": "~2.8",
        "squizlabs/php_codesniffer": "~1.5"
    }
}
EOL
# Run composer install
cd /home/vagrant/composer && php composer.phar install
# Add them to path
echo "export PATH=\"\$HOME/composer:\$PATH\"" >> /home/vagrant/.bashrc
echo "export PATH=\"\$HOME/composer/vendor/bin:\$PATH\"" >> /home/vagrant/.bashrc


echo ""
echo "$header Downloading and install nodejs"
echo "$header from source (compiling will take a while)..."
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


echo ""
echo "$header Install some global nodejs packages..."
npm install -g grunt-cli
npm install -g bower
npm install -g yo
npm install -g generator-webapp
npm install -g generator-bootstrap
npm install -g generator-angular
npm install -g generator-backbone
npm install -g generator-marionette-frontend


echo ""
echo "$header"
echo "$header Hopefully done!!!"
echo "$header"
