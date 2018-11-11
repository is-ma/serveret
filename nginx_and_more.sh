#! /bin/bash
SERVERET_PATH=$HOME/serveret; [ $USER == 'vagrant' ] && SERVERET_PATH=/vagrant/serveret

# prepare it...
source $SERVERET_PATH/settings.sh
touch $SERVERET_PATH/cache_installed

# go for it
[ $UFW == 'yes' ] && source $SERVERET_PATH/mods/ufw.sh
[ $NGINX_PASSENGER == 'yes' ] && source $SERVERET_PATH/mods/nginx_passenger/install_$ubuntu_name.sh
[ $CONFIG_SITE == 'yes' ] && source $SERVERET_PATH/mods/nginx_passenger/config_generator.sh

# configure deploy.sh
sed -i s+=MY_APP_PATH+=$HOME/$app_name/code+g $SERVERET_PATH/deploy.sh