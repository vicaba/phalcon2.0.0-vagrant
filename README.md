Phalcon1.3.0-vagrant
====================

This virtual machine has the following programs installed:
* Phalcon 2.0.0 BETA3
* Phalcon dev-tools 1.3.3 BETA3
* Apache 2.4.7
* Git 1.9.1

To run this virtual machine with vagrant you should first download vagrant at https://www.vagrantup.com/ and VirtualBox at https://www.virtualbox.org/ and clone this repository or download it in .zip .

Yous should then ```cd ``` into the vagrant folder and run ``` vagrant up ```. VirtualBox will start then and will start downloading and installing the Vagrant Virtual Machine.

When the installation has been completed you should be able to view a web page saying "Hello World!" at http://192.168.33.10:8002/

Configuration
=============

* To ssh to the vagrant machine and change any server configuration run this command (``` vagrant ssh ```).
* To change the private address accessible from the host machine edit the Vagrantfile of the project and modify this line: ``` config.vm.network "private_network", ip: "192.168.33.10" ```.

Coding
======

* Inside the vagrant folder on the host machine there is a folder called share/projects/ that is synched to /var/www/ folder of the server. You can edit the files on the host machine and the changes will be immediatelly synched.
* To create a new project read the Phalcon documentation about creating a new project and how to create a new project from the dev-tools.
