#! /bin/bash
MY_HOME=$HOME; [ $USER == 'vagrant' ] && MY_HOME=/vagrant
SERVERET_PATH=$MY_HOME/serveret

# load config
source $SERVERET_PATH/serveret.conf

# go for it
[ $ISMA_PROMPT_COLORS == 'yes' ] && source $SERVERET_PATH/mods/isma/prompt_colors.sh
[ $ISMA_GIT_SHORTCUTS == 'yes' ] && source $SERVERET_PATH/mods/isma/git_shortcuts.sh

[ $UBUNTU_UPDATE == 'yes' ] && source $SERVERET_PATH/mods/update_ubuntu.sh
[ $TIME_SYNCHRONIZATION == 'yes' ] && source $SERVERET_PATH/mods/time_synchronization.sh

if [ $POSTGRESQL == 'yes' ]; then
  source $SERVERET_PATH/mods/pg/asdf.sh
  source $SERVERET_PATH/mods/pg/pg.sh
  source $SERVERET_PATH/mods/pg/port.sh
  [ $pg_reload_on_reboot == 'yes' ] && source $SERVERET_PATH/mods/pg/cronjob.sh
  [ $pg_allow_remote_access == 'yes' ] && source $SERVERET_PATH/mods/pg/allow_remote_access.sh
  source $SERVERET_PATH/mods/pg/start.sh
fi

if [ $RAILS == 'yes' ]; then
  source $SERVERET_PATH/mods/ruby/rbenv.sh
  source $SERVERET_PATH/mods/ruby/ruby.sh
  source $SERVERET_PATH/mods/ruby/bundler.sh
  source $SERVERET_PATH/mods/node/nvm.sh
  source $SERVERET_PATH/mods/node/node.sh
  source $SERVERET_PATH/mods/rails.sh
fi

[ $UFW == 'yes' ] && source $SERVERET_PATH/mods/ufw.sh
[ $NGINX_PASSENGER == 'yes' ] && source $SERVERET_PATH/mods/nginx_passenger/install_$ubuntu_name.sh
[ $INSTALL_RAILS_EXAMPLE_APP == 'yes' ] && source $SERVERET_PATH/mods/nginx_passenger/config_example.sh