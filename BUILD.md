Server Setup
============

I have used Webfaction as my hosting company for my website. You can use my affiliate link if you wish to also: 

Initial Deployment
==================
Create a Ruby on Rails with Passenger application called www
Create a MySQL database with a user

Setup Git with keys etc
Add ruby, gem library etc paths to ~/.bashrc
Export secret keys to ~/.bashrc
	
	git clone git@github.com:dylan8902/website.git website
	update nginx conf to have correct root and environemnt
	cd www/
	bundle install
	rake db:migrate RAILS_ENV=production
	rake assets:precompile
	cd ../
	./bin/restart

Deploy Latest Version
=====================

To update the app:

	ssh <USER>@<SERVER>
	cd ~/webapps/www/website
	git reset --hard
	git pull origin
	bundle install
	rake db:migrate RAILS_ENV=production
	touch tmp/restart.txt