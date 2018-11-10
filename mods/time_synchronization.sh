#! /bin/bash
this_file=mods/time_synchronization.sh

if grep -q TIME_SYNCHRONIZED $SERVERET_PATH/cache_installed; then
  echo "OK $this_file"
else

  # configure time
  echo -n "- $this_file... "
  sudo timedatectl set-timezone $timezone
  sudo timedatectl set-ntp on

  # bookmark (or fail)
  if timedatectl | grep -q "Time zone: $timezone"; then
    echo TIME_SYNCHRONIZED >> $SERVERET_PATH/cache_installed
    echo "DONE, CONFIRMED"
  else
    echo "FAIL"
  fi

fi