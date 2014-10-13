My vagrant dev box setup
========================
Ubuntu 12.04 (precise32) vagrant box with
LAMP-stack (with nodejs).


## Install

`vagrant up`

This will install new virtual machine and use *provision.sh* shell
script for provisioning. It will install apache, php, mysql and nodejs.
This will propably take a while (last time checked ~20min).

Mysql servers root password is defined in recipes/mysql.sh-script. You can change it
if you feel like it.

Host machines port 8080 will be forwarded to guest machines port 80. This
is defined in *Vagrantfile* line 15. This can be also changed.

Apache document root is folder *public_html* (*/vagrant/public_html* in guest machine).
When `vagrant up` finishes, you should be able to point your browser to 
[http://localhost:8080/](http://localhost:8080/) and see some greetings if everyhing went well.


## Uninstall

`vagrant destroy`

This will remove traces of virtual machine but will leave modification made to this folder
(shared folder) in place.




