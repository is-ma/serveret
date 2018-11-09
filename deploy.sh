#! /bin/bash
source ~/serveret/settings.sh

if [ $USER == 'root' ]; then
  echo "- ERROR: you are root"
else

  APP_PATH=$HOME/$app_name/code

  cd $APP_PATH
  # let's deploy
  git pull > /dev/null 2>&1
  bundle install --deployment --without development test > /dev/null 2>&1
  RAILS_ENV=production rails db:migrate assets:clobber assets:precompile > /dev/null 2>&1
  # restart Passeger
  touch $APP_PATH/tmp/restart.txt
  # show current version (HEAD)
  printf "\n\n"
  echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
  echo "TAG: $(git tag --points-at HEAD)"
  git show -s --format=%h > $APP_PATH/public/version.txt
  git log --oneline -n1
  echo ""

fi
