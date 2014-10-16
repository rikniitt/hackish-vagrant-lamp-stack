#!/usr/bin/env bash

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

