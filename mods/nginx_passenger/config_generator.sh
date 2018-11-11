#! /bin/bash

this_file=mods/nginx_passenger/config_generator.sh

if ! grep -q NGINX_PASSENGER_INSTALLED $SERVERET_PATH/cache_installed; then
  echo " - ERROR $this_file: install Passenger first"
else

  # generate the site.conf (idempotent)
  echo "- $this_file... "
  sudo rm /etc/nginx/sites-enabled/*  # delete default
  site_conf=$HOME/"$app_name".conf
  echo "server {" > $site_conf
  echo "  server_name $server_name;" >> $site_conf
  echo "  listen $listen;" >> $site_conf
  echo "  root /home/$USER/$app_name/code/public;" >> $site_conf
  echo "  passenger_enabled on;" >> $site_conf
  echo "  passenger_app_env $rails_env;" >> $site_conf
  echo "  passenger_ruby /home/$USER/.rbenv/shims/ruby;" >> $site_conf
  
  # useful on staging
  on_off=off
  [ $friendly_errors == 'yes' ] && on_off=on
  echo "  passenger_friendly_error_pages $on_off;" >> $site_conf
  
  # remove Nginx version
  echo "  server_tokens off;" >> $site_conf
  echo "" >> $site_conf
  echo "  location ^~ /assets/ {" >> $site_conf
  
  # serve precompiled gz files from Nginx
  echo "    gzip_static on;" >> $site_conf
  
  # Thu, 31 Dec 2037 23:55:55 GMT
  echo "    expires max;" >> $site_conf
  echo "    add_header Cache-Control public;" >> $site_conf
  echo "  }" >> $site_conf
  echo "}" >> $site_conf
  
  sudo mv $site_conf /etc/nginx/sites-available/
  sudo ln -s /etc/nginx/sites-available/"$app_name".conf /etc/nginx/sites-enabled/
  sudo service nginx restart

  # bookmark
  echo "DONE"
fi
