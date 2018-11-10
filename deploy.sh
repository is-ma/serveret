#! /bin/bash

app_path=MY_APP_PATH  # this path is set by online_only.sh

if [ $USER == 'root' ]; then
  echo "- ERROR: you are root"
elif [ $USER == 'vagrant' ]; then
  echo "- ERROR: you are vagrant (on dev machine)"
elif [ $app_path == 'MY_APP_PATH' ]; then
  echo "- ERROR: to set up deploy.sh, run online_only.sh first"
else

  cd $app_path
  # let's deploy
  git pull > /dev/null 2>&1
  bundle install --deployment --without development test > /dev/null 2>&1
  RAILS_ENV=production rails db:migrate assets:clobber assets:precompile > /dev/null 2>&1
  # restart Passeger
  touch $app_path/tmp/restart.txt
  # show current version (HEAD)
  printf "\n\n"
  echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
  echo "TAG: $(git tag --points-at HEAD)"
  git show -s --format=%h > $app_path/public/version.txt
  git log --oneline -n1
  echo ""

fi
