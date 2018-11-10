#! /bin/bash

#################################################
#                CONFIGURATION
#################################################
CUSTOM_USER=yes  # creates a user and copy serveret/ proyect there
my_user=deploy  # creates user (sudo), will have same SSH keys as root
my_pass=password  # won't be used for server access
root_pass=$my_pass  # choose one or same as my_pass; won't be used to login in



#################################################
#                    SCRIPT
#################################################
if [ $USER != 'root' ]; then
  echo "- ERROR: you are not root"
else

  # go for it
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
