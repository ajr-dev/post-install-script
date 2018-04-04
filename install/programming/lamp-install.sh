#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations"

# http://www.2daygeek.com/install-lamp-stack-apache-mariadb-php-phpmyadmin-on-linuxmint/#
# https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-on-ubuntu-16-04
echo "Installing apache2, php7, mysql-server"
echo "========================================================================"
sudo apt-get install -y apache2 mariadb-server mariadb-client
sudo mysql_secure_installation
sudo apt-get install -y php7.0 php7.0-mysql libapache2-mod-php7.0 \
    php7.0-mbstring php7.0-common php7.0-gd php7.0-mcrypt php-gettext \
    php7.0-curl php7.0-cli
sudo apt-get install -y phpmyadmin php-mbstring php-gettext
sudo ln -s /usr/share/phpmyadmin/ /var/www/phpmyadmin

[ ! -d ~/code/public ]  &&  mkdir -p ~/code/public
sudo ln -s /usr/share/phpmyadmin/ ~/code/public

# Create local public folder
if [[ ! -f /etc/apache2/sites-available/000-default.conf.bak ]]; then
    sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.bak
    sudo sed -i "s:DocumentRoot /var/www/html:DocumentRoot $HOME/code/public" /etc/apache2/sites-available/000-default.conf
fi
if [[ ! -f /etc/apache2/apache2.conf ]]; then
    sudo cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
    sudo sed -i "s:<Directory /var/www:<Directory /home/user/code/public" /etc/apache2/sites-available/000-default.conf
fi
sudo chmod 711 /home  &&  sudo chmod 711 "$HOME"  &&  sudo chmod 711 "$HOME/code"
sudo chmod 711 "$HOME/code/public"

# Display errors when programming in php
if [[ ! -f /etc/php/7.0/apache2/php.ini.bak ]]; then
    sudo cp /etc/php/7.0/apache2/php.ini /etc/php/7.0/apache2/php.ini.bak
    sudo sed -i 's/display_errors = Off/display_errors = On/' /etc/php/7.0/apache2/php.ini
    sudo sed -i 's/display_startup_errors = Off/display_startup_errors = On/' /etc/php/7.0/apache2/php.ini
fi

# Restart all the installed services to verify that everything is installed properly
clear
service apache2 restart && service mysql restart > /dev/null
if [ $? -ne 0 ]; then
    read -t "$DELAY" -p "Please Check the Install Services, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)"
else
    read -t "$DELAY" -p "Installed Services run $(tput bold)$(tput setaf 2)Sucessfully$(tput sgr0)"
fi
echo "========================================================================"
echo "apache2, php5, mysql-server has been installed"
echo "========================================================================"
