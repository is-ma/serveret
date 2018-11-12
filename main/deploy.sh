#! /bin/bash
app_path=/path/to/my/rails/code
SERVERET_PATH=$HOME/serveret; [ $USER == 'vagrant' ] && SERVERET_PATH=/vagrant/serveret

# load config
source /root/serveret/serveret.conf

# let's deploy
cd $app_path
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