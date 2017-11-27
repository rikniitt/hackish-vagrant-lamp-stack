#!/usr/bin/env bash

# Create nanorc file
touch /home/vagrant/.nanorc
chown vagrant:vagrant /home/vagrant/.nanorc
cat >> /home/vagrant/.nanorc <<EOL
include /usr/share/nano/c.nanorc
include /usr/share/nano/css.nanorc
include /usr/share/nano/html.nanorc
include /usr/share/nano/java.nanorc
include /usr/share/nano/makefile.nanorc
include /usr/share/nano/perl.nanorc
include /usr/share/nano/php.nanorc
include /usr/share/nano/python.nanorc
include /usr/share/nano/ruby.nanorc
include /usr/share/nano/sh.nanorc
include /usr/share/nano/xml.nanorc
EOL

# Enable syntax highlighting in less
apt-get install -y libsource-highlight-common source-highlight
cat >> /home/vagrant/.bashrc <<EOL
# Less syntax highligting
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '
EOL
