#! /bin/bash
# test: sudo ls /etc/nginx/sites-enabled/

SERVERET_PATH=$HOME/serveret; [ $USER == 'vagrant' ] && SERVERET_PATH=/vagrant/serveret

echo "- mods/nginx_passenger/config_example.sh"
hour_app_repo='https://github.com/is-ma/hour-app.git --branch v1.0.0'
git clone $hour_app_repo $SERVERET_PATH/../hour_app/code > /dev/null 2>&1
cd $SERVERET_PATH/../hour_app/code

export RAILS_ENV=staging
bundle install --deployment --without development test > /dev/null 2>&1
#rails credentials:show  # intermediate testing
rails assets:clobber
rails assets:precompile

rails db:create
rails db:migrate
rails db:seed

sudo rm /etc/nginx/sites-enabled/*  # delete default
echo "
server {
  server_name _;  # "_" is a catch-all domain
  listen 80;
  root /home/$USER/hour_app/code/public;
  passenger_ruby /home/$USER/.rbenv/shims/ruby;
  passenger_app_env staging;  # if staging, Rails environments/staging.rb must exist!
  passenger_friendly_error_pages on;  # on|off, this is great for staging
  passenger_enabled on;

  server_tokens off;  # remove version

  location ^~ /assets/ {
    gzip_static on;  # serve precompiled gz files from Nginx
    expires max;  # Thu, 31 Dec 2037 23:55:55 GMT
    add_header Cache-Control public;
  }
}
" > $HOME/hour_app.conf

sudo mv $HOME/hour_app.conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/hour_app.conf /etc/nginx/sites-enabled/
sudo service nginx restart