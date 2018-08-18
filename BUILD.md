## Deploy

- Create a droplet on Digital Ocean using the Ruby on Rails application image
- Login with the root password e-mailed to you

``` bash
apt-get install git
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
ssh-keygen -t rsa -C "your_email@example.com"
```

- Add the public key generated to your Github Profile

``` bash
rm -rf /home/rails
git clone git@github.com:dylan8902/website.git /home/rails
cd /home/rails
rvm install 2.3.1
rvm use 2.3.1 --default
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

- Set up the database and asset pipeline and restart

``` bash
rake db:create RAILS_ENV=production
rake db:migrate RAILS_ENV=production
rake assets:precompile RAILS_ENV=production
cd ..
chown -R rails rails/
chgrp -R www-data rails/
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
service unicorn restart
```


## Update Let's Encrypt SSL

``` bash
rm dyl.anjon.es.key.old
rm dyl.anjon.es.crt.old
./certbot-auto --text --agree-tos --email dyl@anjon.es -d dyl.anjon.es --manual --preferred-challenges dns --expand --renew-by-default  --manual-public-ip-logging-ok certonly
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


## Contribute

Please feel free to make pull requests!
