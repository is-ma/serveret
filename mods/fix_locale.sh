#! /bin/bash
# updates locale, no more LC_ALL errors when installing other packages
this_file=mods/fix_locale.sh

if grep -q LOCALE_FIXED $cache_path; then
  echo "OK $this_file"
else

  # fixing locale...
  echo -n "- fixing locale... "
  echo -e "LANG=en_US.UTF-8\nLANGUAGE=en_US.UTF-8\nLC_ALL=en_US.UTF-8" | sudo tee /etc/default/locale > /dev/null

  # bookmark
  echo LOCALE_FIXED >> $cache_path
  echo "DONE"

fi
