## Develop

- Set up database
``` bash
brew install mysql@8.4
brew services start mysql@8.4
```

- Setup Ruby and Rails

``` bash
rvm install ruby-3.4.1 --reconfigure --enable-yjit --with-openssl-dir=$(brew --prefix openssl)
rvm use 3.4.1 --default
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
brew install nvm yarn
nvm use
export NODE_OPTIONS=--openssl-legacy-provider
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

- Create the database user:

``` sql
mysql
CREATE USER ''@'localhost' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON *.* TO ''@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit
```

``` bash
rm -rf /home/rails
git clone git@github.com:dylan8902/website.git /home/rails
cd /home/rails
```

- Set the secrets in config/secrets.yml.example and rename:

``` bash
vi config/secrets.yml.example
mv config/secrets.yml.example config/secrets.yml
```

- Set up the database:

``` bash
rake db:create RAILS_ENV=production
```

``` sql
mysql
ALTER DATABASE dylan8902_website CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;
exit
```

- Set up SSL

``` bash
cp config/server/default /etc/nginx/sites-enabled/default
openssl dhparam -out /root/dhparams.pem 2048
```

- Follow Let's Encrypt SSL instructions below

- Build and run:

``` bash
bin/deploy
```

## Update Application

``` bash
/home/rails/bin/deploy
```


## Update Let's Encrypt SSL

``` bash
certbot certonly \
  --text \
  --agree-tos \
  --email dyl@anjon.es \
  --manual \
  --preferred-challenges dns \
  --expand \
  --renew-by-default \
  --manual-public-ip-logging-ok \
  -d dyl.anjon.es \
  -d ismytraindelayed.com \
  -d isitaproxyproblem.com \
  -d dylanjones.info \
  -d alice-jones.co.uk
rm dyl.anjon.es.key.old
rm dyl.anjon.es.crt.old
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


## Backup Database
``` bash
# Create backup on web server
mysqldump dylan8902_production --ignore-table=dylan8902_production.analytics > /tmp/dylan8902_production.sql
# Download backup from local machine
scp root@dyl.anjon.es:/tmp/dylan8902_production.sql ~/Downloads/dylan8902_production.sql
```


## Contribute

Please feel free to make pull requests!
