#! /bin/bash

# set path
SERVERET_PATH=$HOME/serveret  # unless you're 'vagrant' (see below)
[ $USER == 'vagrant' ] && SERVERET_PATH=/vagrant/serveret
 
# fix locale
if grep -q LOCALE_FIXED $SERVERET_PATH/cache_installed; then
  echo "OK init.sh"
else

  # fixing locale...
  echo -n "- fixing locale... "
  echo -e "LANG=en_US.UTF-8\nLANGUAGE=en_US.UTF-8\nLC_ALL=en_US.UTF-8" | sudo tee /etc/default/locale > /dev/null

  # bookmark
  echo LOCALE_FIXED >> $SERVERET_PATH/cache_installed
  echo "DONE (log out then log back in, try 'locale')"
fi

# create a user (if root)
if [ $USER == 'root' ]; then

  # go for it
  source $HOME/serveret/settings.sh
  [ $CUSTOM_USER == 'yes' ] && source $HOME/serveret/mods/create_my_user.sh

  # next step
  echo ""
  echo "#################################################"
  echo "What to do now?"
  echo ""
  echo "  su - $my_user  # to login with your new user"
  echo "  source $HOME/serveret/provision.sh  # to install required software"
  echo ""

fi
