#!/usr/bin/env bash

# Add third party PPA for installing PHP.
add-apt-repository -y ppa:ondrej/php5-oldstable
# Update package index again.
apt-get -y update