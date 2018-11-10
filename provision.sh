#! /bin/bash

# set path
SERVERET_PATH=$HOME/serveret  # unless you're 'vagrant' (see below)
[ $USER == 'vagrant' ] && SERVERET_PATH=/vagrant/serveret

# install software (if not root)
if [ $USER == 'root' ]; then
  echo "- ERROR: you are root"
else

  # prepare it...
  source $SERVERET_PATH/settings.sh
  touch $SERVERET_PATH/cache_installed

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

  # next step
  echo "
#################################################
What to do now? (keep this file visible)

development:
  git clone $app_repo /vagrant/$app_name/code
  cd /vagrant/$app_name/code

  bundle install --without production

  rails db:create  # recreate your config/database.yml first
  rails db:migrate
  rails db:seed
  rails s  # test it is working on port 3000

staging/production:
  git clone $app_repo ~/$app_name/code
  cd ~/$app_name/code

  export RAILS_ENV=staging  # staging/production
  bundle install --deployment --without development test
  # add config/database.yml, config/master.key
  rails credentials:show  # test
  rails assets:clobber
  rails assets:precompile
  echo -e '\ncd ~/$app_name/code' >> ~/.bashrc

  rails db:create
  rails db:migrate
  rails db:seed
  rails s  # test it is working on port 3000

  source $SERVERET_PATH/nginx_and_more.sh  # UFW, Nginx, ...

"

fi
