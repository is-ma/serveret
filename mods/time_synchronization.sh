#! /bin/bash
this_file=mods/time_synchronization.sh

if grep -q TIME_SYNCHRONIZED $cache_path; then
  echo "OK $this_file"
elif [ -z "$timezone" ]; then
  echo "- ERROR $this_file: timezone" 
else

  # configure time
  echo -n "- $this_file... "
  sudo timedatectl set-timezone $timezone
  sudo timedatectl set-ntp on

  # bookmark (or fail)
  if timedatectl | grep -q "Time zone: $timezone"; then
    echo TIME_SYNCHRONIZED >> $cache_path
    echo "DONE, CONFIRMED"
  else
    echo "FAIL"
  fi

fi
