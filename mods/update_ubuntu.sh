#! /bin/bash
this_file=mods/update_ubuntu.sh

if grep -q UBUNTU_UPDATED $cache_path; then
  echo "OK $this_file"
else

  # updating...
  echo -n "- $this_file... "
  sudo apt-get -y update >/dev/null

  # bookmark
  echo UBUNTU_UPDATED >> $cache_path
  echo "DONE"
 
fi
