## Develop

- Set up database
``` bash
brew install mysql
```

- Setup Ruby and Rails

``` bash
rvm install 3.2.2
rvm use 3.2.2 --default
bundle install
```

- Set up SSL

``` bash
sudo certbot --text --agree-tos --email dyl@anjon.es -d dev.dyl.anjon.es --manual --preferred-challenges dns --expand --renew-by-default --manual-public-ip-logging-ok certonly
sudo chown dylan8902 /etc/letsencrypt/live/dev.dyl.anjon.es/../../archive/dev.dyl.anjon.es/*
```

- Set the secrets in config/secrets.yml:

``` bash
cp config/secrets.yml.example config/secrets.yml
vi config/secrets.yml
```

- Set up yarn

``` bash
brew install yarn
yarn install
```

- Run in development mode
``` bash
rails s -b 'ssl://dev.dyl.anjon.es:3000?key=/etc/letsencrypt/live/dev.dyl.anjon.es/privkey.pem&cert=/etc/letsencrypt/live/dev.dyl.anjon.es/fullchain.pem'
```

## Deploy

- Create a droplet on Digital Ocean using the Ruby on Rails application image
- Login with the root password e-mailed to you

``` bash
apt-get install git make nodejs libmysqlclient-dev
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
ssh-keygen -t rsa -C "your_email@example.com"
```

- Add the public key generated to your Github Profile

``` bash
rm -rf /home/rails
git clone git@github.com:dylan8902/website.git /home/rails
cd /home/rails
rvm install 3.2.2
rvm use 3.2.2 --default
bundle install
```

- Create the database user:

``` sql
mysql
CREATE USER ''@'localhost' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON *.* TO ''@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
ALTER DATABASE dylan8902_website CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;
exit
```
- Set the secrets in config/secrets.yml.example and rename:

``` bash
vi config/secrets.yml.example
mv config/secrets.yml.example config/secrets.yml
```

- Setup the web server configuration:

``` bash
cp config/server/unicorn /etc/default/unicorn
```

- Set up the database and asset pipeline and restart

``` bash
rake db:create RAILS_ENV=production
rake db:migrate RAILS_ENV=production
rake assets:precompile RAILS_ENV=production
bin/webpack
chown -R rails /home/rails/
chgrp -R www-data /home/rails/
service unicorn restart
```

- Set up SSL

``` bash
cp config/server/default /etc/nginx/sites-enabled/default
openssl dhparam -out /root/dhparams.pem 2048
vi dyl.anjon.es.crt
vi dyl.anjon.es.key
service nginx restart
```


## Update Application

``` bash
cd /home/rails
git pull
rake db:migrate RAILS_ENV=production
rake assets:precompile RAILS_ENV=production
cd ..
chown -R rails rails/
chgrp -R www-data rails/
service unicorn restart
```


## Update Let's Encrypt SSL

``` bash
rm dyl.anjon.es.key.old
rm dyl.anjon.es.crt.old
certbot --text --agree-tos --email dyl@anjon.es -d dyl.anjon.es -d ismytraindelayed.com -d isitaproxyproblem.com --manual --preferred-challenges dns --expand --renew-by-default  --manual-public-ip-logging-ok certonly
cp dyl.anjon.es.crt dyl.anjon.es.crt.old
cp dyl.anjon.es.key dyl.anjon.es.key.old
cp /etc/letsencrypt/live/dyl.anjon.es/fullchain.pem dyl.anjon.es.crt
cp /etc/letsencrypt/live/dyl.anjon.es/privkey.pem dyl.anjon.es.key
service nginx restart
```


## MySQL support for emojis

/etc/mysql/my.cnf
```
[client]
default-character-set = utf8mb4

[mysql]
default-character-set = utf8mb4

[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
```

``` sql
mysql
ALTER DATABASE dylan8902_website CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;
ALTER TABLE tweets CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
ALTER TABLE monzo_transactions CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
```


## Upgrade to Rails 7.0
``` bash
bundle update
yarn install
rake db:migrate
```


## Backup Database
``` bash
# Create backup on web server
mysqldump dylan8902_production --ignore-table=dylan8902_production.analytics > /tmp/dylan8902_production.sql
# Download backup from local machine
scp root@dyl.anjon.es:/tmp/dylan8902_production.sql ~/Downloads/dylan8902_production.sql
```


## Contribute

Please feel free to make pull requests!
