#! /bin/bash
echo "- mods/nginx_passenger/config_example.sh"
hour_app_repo='https://github.com/is-ma/hour-app.git --branch v1.0.1'
git clone $hour_app_repo $MY_HOME/hour_app/code > /dev/null 2>&1
cd $MY_HOME/hour_app/code

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
  root $MY_HOME/hour_app/code/public;
  passenger_ruby $HOME/.rbenv/shims/ruby;
  passenger_app_env $rails_env;  # if staging, Rails environments/staging.rb must exist!
  passenger_friendly_error_pages on;  # on|off, this is great for staging
  passenger_enabled on;

  server_tokens off;  # remove version

  location ^~ /assets/ {
    gzip_static on;  # serve precompiled gz files from Nginx
    expires max;  # Thu, 31 Dec 2037 23:55:55 GMT
    add_header Cache-Control public;
  }
}" > hour_app.conf
sudo mv hour_app.conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/hour_app.conf /etc/nginx/sites-enabled/

source $MY_HOME/serveret/main/deploy.sh
sudo service nginx restart  # needed to take the new Nginx configuration
