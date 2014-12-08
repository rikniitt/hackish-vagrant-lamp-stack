Hackish vagrant lamp stack
========================
My development Ubuntu 12.04 (precise32) vagrant 
configuration with LAMP-stack.


## Install

`vagrant up`

This will install new virtual machine and use *bash_provision/provision.sh* shell
script for provisioning. It will install apache, php, mysql and some other helpful tools.
This will propably take a while (last time checked ~4min and ~18min with nodejs).
Even longer if you haven't used vagrant before or used base box is already downloaded.

Mysql servers root password is defined in *bash_provision/recipes/mysql.sh*-script. 
You can change it if you feel like it.

Host machines port 8080 will be forwarded to guest machines port 80. This
is defined in *Vagrantfile* line 15. This can be also changed.

Apache document root is folder *public_html* (*/vagrant/public_html* in guest machine).
When `vagrant up` finishes, you should be able to point your browser to 
[http://localhost:8080/](http://localhost:8080/) and see some greetings if everyhing went well.

### Optional tools to install

Check *bash_provision/provision.sh* for complete list of what is done during provision.
You can install sqlite or nodejs by uncommenting lines from provision script.

Also you can add packages which are installed via apt in 
*bash_provision/recipes/basic_packages.sh* if something you need is missing.


## Uninstall

`vagrant destroy`

This will remove traces of virtual machine but will leave modification made to this folder
(shared folder) in place.
