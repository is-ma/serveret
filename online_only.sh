#! /bin/bash
source ~/serveret/settings.sh
cache_path=$HOME/serveret/cache_installed

#################################################
# online_only.sh                    ONLINE ONLY #
#################################################

if [ $USER == 'root' ]; then
  echo "- ERROR: you are root"
else

  # prepare it...
  touch $cache_path

  # go for it
  [ $UFW == 'yes' ] && source ~/serveret/mods/ufw.sh
  [ $NGINX_PASSENGER == 'yes' ] && source ~/serveret/mods/nginx_passenger/install_$ubuntu_name.sh
  [ $CONFIG_SITE == 'yes' ] && source ~/serveret/mods/nginx_passenger/config_generator.sh

  # next step
  echo '

#################################################
What to do now?

Helpers:
  source $HOME/serveret/deploy.sh  # and alias it from dev machine!

'

fi
