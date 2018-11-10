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
cache_path=~/serveret/cache_installed

if [ $USER == 'root' ]; then
  echo "- ERROR: you are root"
else

  # prepare it...
  touch $cache_path

  # go for it
  [ $ISMA_PROMPT_COLORS == 'yes' ] && source ~/serveret/mods/isma/prompt_colors.sh
  [ $ISMA_GIT_SHORTCUTS == 'yes' ] && source ~/serveret/mods/isma/git_shortcuts.sh

  [ $FIX_LOCALE == 'yes' ] && source ~/serveret/mods/fix_locale.sh
  [ $UBUNTU_UPDATE == 'yes' ] && source ~/serveret/mods/update_ubuntu.sh
  [ $TIME_SYNCHRONIZATION == 'yes' ] && source ~/serveret/mods/time_synchronization.sh

  if [ $POSTGRESQL == 'yes' ]; then
    source ~/serveret/mods/pg/asdf.sh
    source ~/serveret/mods/pg/pg.sh
    source ~/serveret/mods/pg/port.sh
    [ $pg_reload_on_reboot == 'yes' ] && source ~/serveret/mods/pg/cronjob.sh
    [ $pg_allow_remote_access == 'yes' ] && source ~/serveret/mods/pg/allow_remote_access.sh
    source ~/serveret/mods/pg/start.sh
  fi

  if [ $RAILS == 'yes' ]; then
    source ~/serveret/mods/ruby/rbenv.sh
    source ~/serveret/mods/ruby/ruby.sh
    source ~/serveret/mods/ruby/bundler.sh
    source ~/serveret/mods/node/nvm.sh
    source ~/serveret/mods/node/node.sh
    source ~/serveret/mods/rails.sh
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
  source ~/serveret/deploy.sh  # helper; alias it from dev machine!

  rails db:create
  rails db:migrate
  rails db:seed
  rails s  # test it is working on port 3000

  source ~/serveret/online_only.sh  # UFW, Nginx, ...
"

fi
