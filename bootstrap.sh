#!/usr/bin/env bash

sudo apt-get update;
sudo apt-get upgrade -y;

sudo apt-get install -y apache2;
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server;
sudo mysqladmin -u root password 'vagrant';
sudo apt-get install -y php5-mysql;
sudo mysql_install_db;
sudo mysql_secure_installation << EOF
vagrant                         
n
n
n
n
n
n
EOF

sudo apt-get install -y git-core gcc autoconf make
sudo apt-get install -y php5-dev php5-mysql

sudo apt-get install -y libpcre3-dev;
sudo apt-get install -y php5;
sudo apt-get install -y libapache2-mod-php5;
sudo apt-get install -y php5-mcrypt;

# install phalcon
sudo -i

git clone --depth=1 git://github.com/phalcon/cphalcon.git;

cd ./cphalcon/build/;

sudo ./install;

echo 'extension=phalcon.so' | sudo tee -a /etc/php5/mods-available/phalcon.ini
cd /etc/php5/mods-available;
sudo php5enmod phalcon;

cd ~;

sudo apachectl restart;

sudo curl -s http://getcomposer.org/installer | php;

echo '{
    "require": {
        "phalcon/devtools": "dev-master"
    }
}' > composer.json;

php composer.phar install;

sudo ln -s ~/vendor/bin/phalcon.php /usr/bin/phalcon;
sudo chmod ugo+x /usr/bin/phalcon;

a2enmod rewrite;


sudo apachectl restart;

cd ~;

cp -R vendor/phalcon /home/vagrant/;
chown vagrant:vagrant /home/vagrant/vendor/phalcon;

sudo apt-get install -y debconf-utils=1.5.51ubuntu2;

sudo echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | sudo debconf-set-selections;
sudo echo 'phpmyadmin phpmyadmin/app-password-confirm password vagrant' | sudo debconf-set-selections;
sudo echo 'phpmyadmin phpmyadmin/mysql/admin-pass password vagrant' | sudo debconf-set-selections;
sudo echo 'phpmyadmin phpmyadmin/mysql/app-pass password vagrant' | sudo debconf-set-selections;
sudo echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | sudo debconf-set-selections;
sudo apt-get install -y phpmyadmin=4:4.0.10-1;

sudo php5enmod mcrypt;

sudo cp -R /vagrant/config/projects/* /var/www/;

sudo cp -R /vagrant/config/apache2/ /etc/ && sudo chown -R root:root /etc/apache2/;

sudo service apache2 restart;

# sudo cp -R /etc/apache2/ /vagrant/config/
# sudo cp -R /etc/php5/apache2/php.ini /vagrant/config/

