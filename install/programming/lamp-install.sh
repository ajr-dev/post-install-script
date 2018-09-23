#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

# http://www.2daygeek.com/install-lamp-stack-apache-mariadb-php-phpmyadmin-on-linuxmint/#
# https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04
# https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-on-ubuntu-16-04
echo "Installing apache2, php7, mysql-server"
echo "========================================================================"
sudo apt-get update && sudo apt-get upgrade

# [Install Apache]
sudo apt-get install -y apache2

sudo apt-get install -y mariadb-server mariadb-client

#sudo mysql_secure_installation

# TODO: this will fail if executed twice. Check and skip if necessary
# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('root') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

# Ubuntu 16 / Linux Mint 18
# sudo apt-get install -y php libapache2-mod-php php-mcrypt php-mysql php-common php-gd php-mbstring php-gettext php-curl php-cli

# Ubuntu 18 / Linux Mint 19
sudo apt install -y php7.2 libapache2-mod-php7.2 php7.2-common php7.2-mbstring php7.2-xmlrpc php7.2-soap php7.2-gd php7.2-xml php7.2-intl php7.2-mysql php7.2-cli php7.2-zip php7.2-curl

# [Creating php info file]
sudo tee -a /var/www/html/info.php << EOF
<?php phpinfo(); ?>
EOF

# Install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

sudo apt-get install -y phpmyadmin
sudo ln -s /usr/share/phpmyadmin/ /var/www/phpmyadmin

# Create local public folder
# https://askubuntu.com/questions/840737/after-lamp-install-cant-run-php-scripts-on-localhost
#[ ! -d ~/code/public ]  &&  mkdir -p ~/code/public
#sudo ln -s /usr/share/phpmyadmin/ ~/code/public
#
#if [[ ! -f /etc/apache2/sites-available/000-default.conf.bak ]]; then
#    sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.bak
#    sudo sed -i "s:DocumentRoot /var/www/html:DocumentRoot $HOME/code/public" /etc/apache2/sites-available/000-default.conf
#fi
#if [[ ! -f /etc/apache2/apache2.conf.bak ]]; then
#    sudo cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
#    sudo sed -i "s:<Directory /var/www:<Directory $HOME/code/public" /etc/apache2/sites-available/000-default.conf
#fi
#sudo chmod 711 /home  &&  sudo chmod 711 "$HOME"  &&  sudo chmod 711 "$HOME/code"
#sudo chmod 711 "$HOME/code/public"

# Display errors when programming in php
#if [[ ! -f /etc/php/7.0/apache2/php.ini.bak ]]; then
#    sudo cp /etc/php/7.0/apache2/php.ini /etc/php/7.0/apache2/php.ini.bak
#    sudo sed -i 's/display_errors = Off/display_errors = On/' /etc/php/7.0/apache2/php.ini
#    sudo sed -i 's/display_startup_errors = Off/display_startup_errors = On/' /etc/php/7.0/apache2/php.ini
#fi

# Restart all the installed services to verify that everything is installed properly
clear
service apache2 restart > /dev/null
if [ $? -ne 0 ]; then
    read -t "$DELAY" -p "$(tput bold)$(tput setaf 1)ERROR$(tput sgr0): reinstall apache"
    exit
fi

service mysql restart > /dev/null
if [ $? -ne 0 ]; then
    read -t "$DELAY" -p "$(tput bold)$(tput setaf 1)ERROR$(tput sgr0): reinstall mysql"
    exit
fi

php -v > /dev/null
if [ $? -ne 0 ]; then
    read -t "$DELAY" -p "$(tput bold)$(tput setaf 1)ERROR$(tput sgr0): reinstall php"
    exit
fi

read -t "$DELAY" -p "Installed Services run $(tput bold)$(tput setaf 2)Sucessfully$(tput sgr0)"

echo "========================================================================"
echo "apache2, php, mysql-server has been installed"
echo "========================================================================"
