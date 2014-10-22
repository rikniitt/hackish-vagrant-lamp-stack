#!/usr/bin/env bash

# Create new folder in home dir
mkdir /home/vagrant/scripts
# Add it to path
echo "export PATH=\"\$HOME/scripts:\$PATH\"" >> /home/vagrant/.bashrc


# Create some helper/placeholder script in it
touch /home/vagrant/scripts/tail_apache_logs
# Create script for opening tailing both default apache logs
cat > /home/vagrant/scripts/tail_apache_logs <<EOL
#!/usr/bin/env bash

# Use this script to tail both default apache log files.

tail -f /var/log/apache2/access.log -f /var/log/apache2/error.log
EOL
chmod +x /home/vagrant/scripts/tail_apache_logs


# Finally change owner to vagrant
chown -R vagrant:vagrant /home/vagrant/scripts
