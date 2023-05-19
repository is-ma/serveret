echo "- toy app"
git clone https://github.com/is-ma/hour-app.git --branch v1.0.4 $HOME/toy_app/code > /dev/null 2>&1
cd $HOME/toy_app/code

bundle config set without 'development test' > /dev/null 2>&1
bundle install > /dev/null 2>&1

# create and setup db
[ $USER != 'deploy' ] && createuser $USER -d
RAILS_ENV=staging rails db:create db:migrate db:seed

# configure Passenger + Nginx
sudo rm /etc/nginx/sites-enabled/*  # delete default
cat << "EOF" > $HOME/toy_app.conf
server {
  listen 80;
  server_name _;  # "_" is a catch-all domain
  root $HOME/toy_app/code/public;
  passenger_ruby $HOME/.asdf/shims/ruby;
  passenger_app_env staging;
  passenger_friendly_error_pages on;
  passenger_enabled on;

  server_tokens off;  # remove version

  location ^~ /assets/ {
    gzip_static on;  # serve precompiled gz files from Nginx
    expires max;  # Thu, 31 Dec 2037 23:55:55 GMT
    add_header Cache-Control public;
  }
}
EOF
sudo mv $HOME/toy_app.conf /etc/nginx/conf.d/

source $HOME/.is-ma/serveret/deploy.sh
sudo service nginx restart  # needed to take the new Nginx configuration
