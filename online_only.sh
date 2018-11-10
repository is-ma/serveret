#! /bin/bash

#################################################
#                CONFIGURATION
#################################################
UFW=yes
#app01=10.10.10.10
#app02=11.11.11.11
dev_machine_ip=111.111.111.111
rules=()
rules+=("allow ssh")                            # any server
rules+=("allow from $dev_machine_ip")           # staging
#rules+=("allow from $app01 to any port 5432")  # production db
#rules+=("allow from $app02 to any port 5432")  # production db

NGINX_PASSENGER=yes
ubuntu_name=xenial  # xenial | ___

CONFIG_SITE=yes  # /etc/nginx/sites-enabled/$app_name.conf
server_name='_'  # "_" is a catch-all domain name; or choose a specific one
listen=80
passenger_friendly_error_pages=on  # it's ok for staging
passenger_app_env=staging  # config/environments/ENVIRONMENT.rb must exists!
app_name=hour_app
app_repo='https://github.com/is-ma/hour-app.git --branch v1.0.0'



#################################################
#                    SCRIPT
#################################################
cache_path=$HOME/serveret/cache_installed
SERVERET_PATH=$HOME/serveret

if [ $USER == 'root' ]; then
  echo "- ERROR: you are root"
else

  # prepare it...
  touch $cache_path

  # go for it
  [ $UFW == 'yes' ] && source $SERVERET_PATH/mods/ufw.sh
  [ $NGINX_PASSENGER == 'yes' ] && source $SERVERET_PATH/mods/nginx_passenger/install_$ubuntu_name.sh
  [ $CONFIG_SITE == 'yes' ] && source $SERVERET_PATH/mods/nginx_passenger/config_generator.sh

  # configure deploy.sh
  sed -i s+MY_APP_PATH+$HOME/$app_name/code+g

  # next step
  echo '

#################################################
What to do now?

Helpers:
  source $HOME/serveret/deploy.sh  # and alias it from dev machine!

'

fi
