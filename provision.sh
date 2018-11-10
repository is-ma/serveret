#! /bin/bash

#################################################
#                CONFIGURATION
#################################################
ISMA_PROMPT_COLORS=yes  # github: is-ma/prompt_colors
ISMA_GIT_SHORTCUTS=yes  # github: is-ma/git_shortcuts

FIX_LOCALE=yes  # errors related to LC_CTYPE, LC_ALL (type 'locale' to test)

UBUNTU_UPDATE=yes  # runs: sudo apt-get -y update >/dev/null 2>&1

TIME_SYNCHRONIZATION=yes
timezone=America/Mexico_City  # find out more timezones with: timedatectl list-timezones

POSTGRESQL=yes
asdf_version=0.6.0  # will install almost any version of PostgreSQL
pg_version=11.1
pg_port=5432
pg_reload_on_reboot=yes  # add a cronjob for you
pg_allow_remote_access=yes  # if yes, limit access to pg_port with UFW

RAILS=yes
ruby_version=2.5.1  # will be installed by rbenv
bundler_version=1.17
nvm_version=0.33.11  # will be used to install Node.js
node_version=10.13.0
rails_version=5.2.1



#################################################
#                    SCRIPT
#################################################
SERVERET_PATH=$HOME/serveret  # unless you're 'vagrant' (see below)

if [ $USER == 'root' ]; then
  echo "- ERROR: you are root"
elif [ $USER == 'vagrant' ]; then
  SERVERET_PATH=/vagrant/serveret
else

  # prepare it...
  touch $SERVERET_PATH/cache_installed

  # go for it
  [ $ISMA_PROMPT_COLORS == 'yes' ] && source $SERVERET_PATH/mods/isma/prompt_colors.sh
  [ $ISMA_GIT_SHORTCUTS == 'yes' ] && source $SERVERET_PATH/mods/isma/git_shortcuts.sh

  [ $FIX_LOCALE == 'yes' ] && source $SERVERET_PATH/mods/fix_locale.sh
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
  git clone $app_repo ~/$app_name/code

  cd /vagrant/$app_name/code
  bundle install --without production

  rails db:create
  rails db:migrate
  rails db:seed
  rails s  # test it is working on port 3000

staging/production:
  git clone $app_repo ~/$app_name/code

  export RAILS_ENV=staging  # staging/production
  cd ~/$app_name/code
  bundle install --deployment --without development test
  # add config/database.yml, config/master.key
  rails credentials:show  # test
  rails assets:clobber
  rails assets:precompile
  echo -e '\ncd ~/$app_name/code' >> ~/.bashrc
  source $SERVERET_PATH/deploy.sh  # helper; alias it from dev machine!

  rails db:create
  rails db:migrate
  rails db:seed
  rails s  # test it is working on port 3000

  source $SERVERET_PATH/nginx_and_more.sh  # UFW, Nginx, ...

"

fi
