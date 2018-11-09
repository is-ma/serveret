#! /bin/bash
source ~/serveret/settings.sh
cache_path=~/serveret/cache_installed

#################################################
# provision.sh        ONLINE (USER) AND VAGRANT #
#################################################

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
