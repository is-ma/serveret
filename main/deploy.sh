#! /bin/bash
MY_HOME=$HOME; [ $USER == 'vagrant' ] && MY_HOME=/vagrant
source $MY_HOME/serveret/serveret.conf
app_path=$MY_HOME/hour_app/code

# let's deploy
cd $app_path
git pull > /dev/null 2>&1
bundle install --deployment --without development test > /dev/null 2>&1
RAILS_ENV=$rails_env rails db:migrate assets:clobber assets:precompile > /dev/null 2>&1
# restart Passeger
touch $app_path/tmp/restart.txt
# show current version (HEAD)
echo "TAG: $(git tag --points-at HEAD)"
git show -s --format=%h > $app_path/public/version.txt
git log --oneline -n1