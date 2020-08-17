# Guest additions
sudo yum install -y epel-release centos-release-scl
sudo yum update -y
sudo yum install -y make gcc kernel-headers kernel-devel perl dkms bzip2
sudo mount -r /dev/cdrom /media
sudo /media
sudo ./VBoxLinuxAdditions.run
sudo reboot
sudo yum install -y dconf-editor
bash <(curl -s https://raw.githubusercontent.com/ajr-dev/post-install-script/master/install/settings/gnome.sh)

# Install apache
sudo yum install -y httpd httpd-devel python3 python3-pip python3-devel
sudo systemctl enable httpd
sudo systemctl start httpd

# Install Python 3.7.4
# sudo yum install -y openssl-devel bzip2-devel libffi-devel
# wget -q 'https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz'
# tar -xzf 'Python-3.7.4.tgz'
# rm 'Python-3.7.4.tgz'
# cd 'Python-3.7.4'
# ./configure --enable-optimizations --enable-shared
# make
# sudo make altinstall
# cd ..
# sudo rm -rf 'Python-3.7.4'

# Install mod_wsgi 4.6.7
wget -q "https://github.com/GrahamDumpleton/mod_wsgi/archive/4.6.7.tar.gz"
tar -xzf '4.6.7.tar.gz'
rm '4.6.7.tar.gz'
cd 'mod_wsgi-4.6.7' || exit
./configure --with-python=/usr/bin/python3
make
sudo make install

#Libraries have been installed in:
#   /usr/lib64/httpd/modules

#If you ever happen to want to link against installed libraries
#in a given directory, LIBDIR, you must either use libtool, and
#specify the full pathname of the library, or use the `-LLIBDIR'
#flag during linking and do at least one of the following:
#   - add LIBDIR to the `LD_LIBRARY_PATH' environment variable
#     during execution
#   - add LIBDIR to the `LD_RUN_PATH' environment variable
#     during linking
#   - use the `-Wl,-rpath -Wl,LIBDIR' linker flag
#   - have your system administrator add LIBDIR to `/etc/ld.so.conf'

# Add this to `/etc/httpd/conf/httpd.conf`
# LoadModule wsgi_module modules/mod_wsgi.so

cd ..
sudo rm -rf 'mod_wsgi-4.6.7'
apachectl restart

sudo cat /var/log/httpd/error_log
# If all is okay, you should see a line of the form:
# Apache/2.4.6 (CentOS) mod_wsgi/4.6.7 Python/3.6 configured

# Flask Deploy with Apache on CentOS
sudo pip3 install flask==1.1.1
cd /var/www || exit
sudo mkdir flask
cd flask || exit
sudo mkdir website
cd website || exit
sudo vi __init__.py

from flask import Flask
app = Flask(__name__)

sudo vi main.py

import sys
import platform

def linux_distribution():
  try:
    return platform.linux_distribution()
  except:
    return "N/A"

@app.route("/")
def hello():
    return """

    Hello World!<br><br>
    <a href="/flask/info/">System Information</a>
  """

@app.route("/info/")
def info():
    return f"""
        Python version: {sys.version}<br>
        dist: {platform.dist()}<br>
        linux_distribution: {linux_distribution()}<br>
        system: {platform.system()}<br>
        machine: {platform.machine()}<br>
        platform: {platform.platform()}<br>
        uname: {platform.uname()}<br>
        version: {platform.version()}<br>
        mac_ver: {platform.mac_ver()}<br>
    """

if __name__ == "__main__":
    app.run(debug=True)

cd ..
sudo vi website.wsgi

import sys
sys.path.insert(0, '/var/www/flask')

from myapp.main import app as application

cd /etc/httpd/conf/
sudo cp httpd.conf httpd.conf.bak
sudo vi httpd.conf

# Insert:
<VirtualHost *:80>

     ServerName localhost

     WSGIScriptAlias /flask /var/www/flask/website.wsgi

     <Directory /var/www/flask>
         Require all granted
     </Directory>

</VirtualHost>

apachectl restart

# Get IP
hostname -I

# Visiting 'http://my_host_ip/helloworld' I see 'Hello World!'
# If you are getting an error you can see it by doing
sudo cat /var/log/httpd/error_log

sudo yum install -y git
git clone http://github.com/ajr-dev/dotfiles/ ~/.dotfiles
cd ~/.dotfiles
