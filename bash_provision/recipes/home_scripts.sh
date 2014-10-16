#!/usr/bin/env bash

# Create new folder in home dir
mkdir /home/vagrant/scripts
# Add it to path
echo "export PATH=\"\$HOME/scripts:\$PATH\"" >> /home/vagrant/.bashrc


# Create some helper/placeholder script in it
touch /home/vagrant/scripts/mysql_console
# Get mysql password defined in mysql-recipe
RECIPE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $RECIPE_DIR/mysql.sh
# Create script for opening mysql console
cat > /home/vagrant/scripts/mysql_console <<EOL
#!/usr/bin/env bash
mysql -uroot -p${MYSQL_ROOT_PASSWORD} --show-warnings
EOL
chmod +x /home/vagrant/scripts/mysql_console

