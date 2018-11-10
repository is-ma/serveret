#! /bin/bash
this_file=mods/update_ubuntu.sh

if grep -q UBUNTU_UPDATED $SERVERET_PATH/cache_installed; then
  echo "OK $this_file"
else

  # updating...
  echo -n "- $this_file... "
  sudo apt-get -y update >/dev/null

  # bookmark
  echo UBUNTU_UPDATED >> $SERVERET_PATH/cache_installed
  echo "DONE"
 
fi
