Login to new server as root
create new <user>
add <user> to sudoers list
login as <user>
sudo yum install git curl-devel mysql mysql-devel mariadb-server -y
cd /tmp/
wget http://nginx.org/download/nginx-1.6.0.tar.gz
tar -zxvf nginx-1.6.0.tar.gz
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.profile
rvm install 2.1.2
gem install passenger
sudo chmod o+x "/home/<user>"
rvmsudo passenger-install-nginx-module
	- use the source in /tmp/nginx-1.6.0
	- install to /opt/
cd /var
sudo mkdir www
sudo chown <user> www
sudo chgrp <user> www
mkdir repo
sudo chown <user> repo
sudo chgrp <user> repo
cd repo
mkdir website.git && cd website.git
git init --bare
vi post-receive
	- put the following content in:
	#!/bin/sh
	git --work-tree=/var/www/website --git-dir=/var/repo/website.git checkout -f
	- save the file
chmod +x post-receive
