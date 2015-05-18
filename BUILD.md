
To Deploy:

- Create a droplet on Digital Ocean using the Ruby on Rails application image
- Login with the root password e-mailed to you

    apt-get install git
    git config --global user.name "Your Name"
    git config --global user.email "your_email@example.com"
    ssh-keygen -t rsa -C "your_email@example.com"

- Add the public key generated to your Github Profile

    rm -rf /home/rails
    git clone git@github.com:dylan8902/website.git /home/rails
    cd /home/rails
    bundle install
    
- Create the database user:

    mysql
    CREATE USER ''@'localhost' IDENTIFIED BY '';
    GRANT ALL PRIVILEGES ON *.* TO ''@'localhost' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
    exit

- Set the secrets in config/secrets.yml.example and rename:

    vi config/secrets.yml.example
    mv config/secrets.yml.example config/secrets.yml

- Set up the database and asset pipeline and restart

    rake db:create RAILS_ENV=production
    rake db:migrate RAILS_ENV=production
    rake assets:precompile RAILS_ENV=production
    cd ..
    chown -R rails rails/
    chgrp -R www-data rails/
    service unicorn restart


To Update:
    cd /home/rails
    git pull
    rake db:migrate RAILS_ENV=production
    rake assets:precompile RAILS_ENV=production
    service unicorn restart


To Contribute:

Please feel free to make pull requests!