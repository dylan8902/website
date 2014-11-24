Initial Build
=============

Login to new server as root
Create new \<user\>
Add \<user\> to sudoers list
Login as \<user\>

	sudo yum install git curl-devel mysql mysql-devel mariadb-server sqlite-devel -y
	cd /tmp/
	wget http://nginx.org/download/nginx-1.6.0.tar.gz
	tar -zxvf nginx-1.6.0.tar.gz
	\curl -sSL https://get.rvm.io | bash -s stable
	source ~/.profile
	rvm install 2.1.2
	gem install passenger
	sudo chmod o+x "/home/<user>"
	rvmsudo passenger-install-nginx-module

Use the source in /tmp/nginx-1.6.0
Install to /opt/nginx
Add argument to install spdy module

	--with-http_spdy_module

	cd /var
	sudo mkdir www
	sudo chown <user> www
	sudo chgrp <user> www

Set up SSH key
Ddd to github and test

	git clone git@github.com:dylan8902/website.git
	sudo cp /var/www/website/config/server/ruby_wrapper /opt/ruby_wrapper
	cd /opt
	sudo chmod a+rwx ruby_wrapper
	sudo chmod u+x set_environment
	sudo vi set_environment

Paste secret keys into set_environment

	source set_environment
	mysql -uroot
	CREATE USER '<DATABASE_USER>'@'localhost' IDENTIFIED BY '<DATABASE_PASSWORD>';
	GRANT ALL ON *.* TO '<DATABASE_USER>'@'localhost';
	FLUSH PRIVILEGES;
	exit
	sudo cp /var/www/website/config/server/nginx.conf /opt/nginx/conf/nginx.conf
	sudo mkdir /opt/nginx/ssl
	cd /opt/nginx/ssl
	sudo vi dyl.anjon.es.crt

Paste SSL certificate into dyl.anjon.es.crt

	sudo vi dyl.anjon.es.csr

Paste SSL certificate request into dyl.anjon.es.csr

	sudo vi /opt/nginx/ssl/dyl.anjon.es.key

Paste SSL certificate key into dyl.anjon.es.key

	cd /var/www/website
	bundle install
	rake db:create RAILS_ENV=production
	rake db:migrate RAILS_ENV=production
	rake assets:precompile
	sudo service nginx start


Deploy Latest Version
=====================

To update the app:

	ssh <USER>@<SERVER> -R 3001:localhost:3306
	cd /var/www/website
	git reset --hard
	git pull origin
	bundle install
	rake db:migrate RAILS_ENV=production
	touch tmp/restart.txt
