#! /bin/bash
source ~/serveret/settings.sh

#################################################
# root_init.sh                    ONLINE (ROOT) #
#################################################

if [ $USER != 'root' ]; then
  echo "- ERROR: you are not root"
else

  # go for it
  [ $CUSTOM_USER == 'yes' ] && source ~/serveret/mods/create_my_user.sh

  # next step
  echo ""
  echo "#################################################"
  echo "What to do now?"
  echo ""
  echo "su - $my_user                          # to login with your new user"
  echo "source ~/serveret/provision.sh  # to install required software"
  echo ""
  echo ""
  echo ""

fi
