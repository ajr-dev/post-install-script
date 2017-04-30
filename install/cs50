#!/bin/bash

# https://github.com/tysonchamp/cs50/blob/master/cs50.sh
sudo apt-get install -y scratch filezilla
echo "========================================================================"
echo "c compiler, default-jdk & jre and filezilla has been installed"
echo "========================================================================"

wget http://mirror.cs50.net/appliance50/2015/debs/dists/trusty/main/binary-i386/check50_1.19-2_i386.deb
wget http://mirror.cs50.net/appliance50/2015/debs/dists/trusty/main/binary-i386/render50_1.8-0_i386.deb
wget http://mirror.cs50.net/appliance50/2015/debs/dists/trusty/main/binary-i386/style50_2.1.4-1_i386.deb
echo "Download completed"
if (( $(uname -a | grep arm) )); then dpkg --force-architecture --force-depends -i check50_1.19-2_i386.deb; else dpkg -i check50_1.19-2_i386.deb; fi
echo "check50 made"
if (( $(uname -a | grep arm) )); then dpkg --force-architecture --force-depends -i style50_2.1.4_i386.deb; else dpkg -i style50_2.1.4-1_i386.deb; fi
echo "style50 made"
if (( $(uname -a | grep arm) )); then dpkg --force-architecture --force-depends -i render50_1.8-0_i386.deb ; else dpkg -i render50_1.8-0_i386.deb; fi
echo "render50 made"
echo "========================================================================"
echo "check50, style50 and render50 have been installed"

clear
echo "Installing custom libraries for C/C++ and php for cs50"
echo "========================================================================"
wget http://mirror.cs50.net/appliance50/2015/debs/dists/trusty/main/binary-i386/library50-c_6-0_i386.deb
dpkg -i library50-c_6-0_i386.deb
rm library50-c_6-0_i386.deb
wget http://mirror.cs50.net/appliance50/2015/debs/dists/trusty/main/binary-i386/library50-php_4-0_i386.deb
dpkg -i library50-php_4-0_i386.deb
rm library50-php_4-0_i386.deb
wget https://github.com/tysonchamp/spl-for-ubuntu/archive/master.zip
unzip master.zip
cd spl-for-ubuntu-master
make
make install
rm -rf master.zip spl-for-ubuntu-master ./*deb*
										   echo "========================================================================"

										   clear
										   echo "
# My custom alias for CS50 By Harvard University
mkcs50() {
echo "cc -ggdb -std=c99 -Wall -Werror ${1}.c -lcrypt -lcs50 -lm -o $1";
cc -ggdb -std=c99 -Wall -Werror ${1}.c -lcrypt -lcs50 -lm -o $1 ;
}
alias mk=mkcs50" | cat >> ~/.bashrc
echo "========================================================================"
source ~/.bashrc
sudo chmod -R 777 /var/www/*

clear
echo "CS50 README
============================================================================
1. Install Browser Addons:
============================================================================
After installation of apliance is finished, install the below addons in your
mozilla firefox web browser:
1) https://addons.mozilla.org/en-US/firefox/addon/1843
2) https://addons.mozilla.org/en-US/firefox/addon/3829
3) https://addons.mozilla.org/en-US/firefox/addon/60
2. Scratch:
============================================================================
Scratch Is already installed but still If you want to access the online
version then visit below url: http://scratch.mit.edu/
3. Install Oracle Java:
============================================================================
If you wanna install through PPA, goto below url
http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html
or,
download from official website
http://java.com/en/download/manual.jsp"
read -n 1 -p "\nContinue?\n"
