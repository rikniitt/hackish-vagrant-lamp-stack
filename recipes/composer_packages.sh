#!/usr/bin/env bash

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
# Add vendor bin to path
echo "export PATH=\"\$HOME/composer/vendor/bin:\$PATH\"" >> /home/vagrant/.bashrc

