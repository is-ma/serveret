#! /bin/bash

# set path
SERVERET_PATH=$HOME/serveret

if [ $USER == 'root' ]; then
  echo "- ERROR: you are root"
elif [ $USER == 'vagrant' ]; then
  echo "- ERROR: you are on dev machine; use Puma instead"
else

  # prepare it...
  source $SERVERET_PATH/settings.sh
  touch $SERVERET_PATH/cache_installed

  # go for it
  [ $UFW == 'yes' ] && source $SERVERET_PATH/mods/ufw.sh
  [ $NGINX_PASSENGER == 'yes' ] && source $SERVERET_PATH/mods/nginx_passenger/install_$ubuntu_name.sh
  [ $CONFIG_SITE == 'yes' ] && source $SERVERET_PATH/mods/nginx_passenger/config_generator.sh

  # configure deploy.sh
  sed -i s+MY_APP_PATH+$HOME/$app_name/code+g $SERVERET_PATH/deploy.sh

  # next step
  echo "

#################################################
What to do now?

Try deploying:
  source $HOME/serveret/deploy.sh  # and alias it from dev machine!

Try deploying from your dev machine (and alias it!):
  alias $app_name$(echo '_')$passenger_app_env='ssh $USER@your_ip:serveret/deploy.sh'

"

fi