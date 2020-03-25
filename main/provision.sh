#! /bin/bash
MY_HOME=$HOME; [ $USER == 'vagrant' ] && MY_HOME=/vagrant
source $MY_HOME/serveret/serveret.conf

# go for it
[ $ISMA_PROMPT_COLORS == 'yes' ] && source $MY_HOME/serveret/mods/isma/prompt_colors.sh
[ $ISMA_GIT_SHORTCUTS == 'yes' ] && source $MY_HOME/serveret/mods/isma/git_shortcuts.sh

[ $UBUNTU_UPDATE == 'yes' ] && source $MY_HOME/serveret/mods/update_ubuntu.sh
[ $TIME_SYNCHRONIZATION == 'yes' ] && source $MY_HOME/serveret/mods/time_synchronization.sh

if [ $POSTGRESQL == 'yes' ]; then
  source $MY_HOME/serveret/mods/pg/asdf.sh
  source $MY_HOME/serveret/mods/pg/pg.sh
  source $MY_HOME/serveret/mods/pg/port.sh
  [ $pg_reload_on_reboot == 'yes' ] && source $MY_HOME/serveret/mods/pg/cronjob.sh
  [ $pg_allow_remote_access == 'yes' ] && source $MY_HOME/serveret/mods/pg/allow_remote_access.sh
  source $MY_HOME/serveret/mods/pg/start.sh
fi

if [ $RAILS == 'yes' ]; then
  source $MY_HOME/serveret/mods/ruby/rbenv.sh
  source $MY_HOME/serveret/mods/ruby/ruby.sh
  source $MY_HOME/serveret/mods/ruby/bundler.sh
  source $MY_HOME/serveret/mods/node/nvm.sh
  source $MY_HOME/serveret/mods/node/node.sh
  source $MY_HOME/serveret/mods/rails.sh
fi

[ $UFW == 'yes' ] && source $MY_HOME/serveret/mods/ufw.sh
[ $NGINX_PASSENGER == 'yes' ] && source $MY_HOME/serveret/mods/nginx_passenger/install_$ubuntu_name.sh
[ $INSTALL_RAILS_APP == 'yes' ] && source $MY_HOME/serveret/mods/nginx_passenger/config_rails_app.sh
