#! /bin/bash
source ~/.serveret/serveret.conf

echo "- mods/nginx_passenger/config_rails_app.sh"
git clone $app_repository ~/rails_app/code > /dev/null 2>&1
cd ~/rails_app/code

bundle install --deployment --without development test > /dev/null 2>&1

# create and setup db
[ $USER != $db_user ] && createuser $db_user -d  # createuser --help
RAILS_ENV=$rails_env rails db:create db:migrate db:seed

# configure Passenger + Nginx
sudo rm /etc/nginx/sites-enabled/*  # delete default
echo "
server {
  server_name _;  # "_" is a catch-all domain
  listen 80;
  root /home/$USER/rails_app/code/public;
  passenger_ruby /home/$USER/.rbenv/shims/ruby;
  passenger_app_env $rails_env;  # if staging, Rails environments/staging.rb must exist!
  passenger_friendly_error_pages on;  # on|off, this is great for staging
  passenger_enabled on;

  server_tokens off;  # remove version

  location ^~ /assets/ {
    gzip_static on;  # serve precompiled gz files from Nginx
    expires max;  # Thu, 31 Dec 2037 23:55:55 GMT
    add_header Cache-Control public;
  }
}" > ~/rails_app.conf
sudo mv ~/rails_app.conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/rails_app.conf /etc/nginx/sites-enabled/

source ~/.serveret/main/deploy.sh
sudo service nginx restart  # needed to take the new Nginx configuration
