#! /bin/bash
source ~/.serveret/serveret.conf

# go for it
[ $ISMA_PROMPT_COLORS == 'yes' ] && source ~/.serveret/mods/isma/prompt_colors.sh
[ $ISMA_GIT_SHORTCUTS == 'yes' ] && source ~/.serveret/mods/isma/git_shortcuts.sh

[ $UBUNTU_UPDATE == 'yes' ] && source ~/.serveret/mods/update_ubuntu.sh
[ $TIME_SYNCHRONIZATION == 'yes' ] && source ~/.serveret/mods/time_synchronization.sh

if [ $POSTGRESQL == 'yes' ]; then
  source ~/.serveret/mods/pg/asdf.sh
  source ~/.serveret/mods/pg/pg.sh
  source ~/.serveret/mods/pg/port.sh
  [ $pg_reload_on_reboot == 'yes' ] && source ~/.serveret/mods/pg/cronjob.sh
  [ $pg_allow_remote_access == 'yes' ] && source ~/.serveret/mods/pg/allow_remote_access.sh
  source ~/.serveret/mods/pg/start.sh
fi

if [ $RAILS == 'yes' ]; then
  source ~/.serveret/mods/ruby/rbenv.sh
  source ~/.serveret/mods/ruby/ruby.sh
  source ~/.serveret/mods/ruby/bundler.sh
  source ~/.serveret/mods/node/nvm.sh
  source ~/.serveret/mods/node/node.sh
  source ~/.serveret/mods/rails.sh
fi

[ $ACK == 'yes' ] && source ~/.serveret/mods/ack/ack.sh
[ $VARNISH_CACHE == 'yes' ] && source ~/.serveret/mods/varnish/$varnish_ver.sh
[ $UFW == 'yes' ] && source ~/.serveret/mods/ufw.sh
[ $NGINX_PASSENGER == 'yes' ] && source ~/.serveret/mods/nginx_passenger/install_for_$nginx_passenger_ubuntu_name.sh
[ $INSTALL_RAILS_APP == 'yes' ] && source ~/.serveret/mods/nginx_passenger/config_rails_app.sh
[ $USER == 'vagrant' ] && cp /home/vagrant/.serveret/serveret.conf /vagrant/