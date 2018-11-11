#! /bin/bash
this_file=mods/nginx_passenger/install_xenial.sh

if grep -q NGINX_PASSENGER_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "OK $this_file"
elif ! grep -q RAILS_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "- ERROR $this_file: install Rails first"
else

  # install Nginx + Passenger
  echo "- $this_file... "
  sudo apt-get install -y dirmngr gnupg > /dev/null 2>&1
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 > /dev/null 2>&1
  sudo apt-get install -y apt-transport-https ca-certificates > /dev/null 2>&1

  sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'
  sudo apt-get update > /dev/null 2>&1

  sudo apt-get install -y nginx-extras passenger > /dev/null 2>&1

  # nginx.conf (idempotent)
  sudo sed -i "s/www-data;/$USER;/" /etc/nginx/nginx.conf
  sudo sed -i "s+# include /etc/nginx/passenger+include /etc/nginx/passenger+" /etc/nginx/nginx.conf

  # start
  sudo service nginx restart

  # bookmark (or fail)
  if /usr/bin/passenger-config list-instances | grep -q 'PID'; then
    echo NGINX_PASSENGER_INSTALLED >> $SERVERET_PATH/cache_installed
    echo "DONE"
  else
    echo "FAIL"
  fi

fi
