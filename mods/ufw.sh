#! /bin/bash
this_file=mods/ufw.sh

if grep -q UFW_RULES_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "OK $this_file"
else

  # install UFW rules
  echo "- $this_file... "
  status_centinel=OK
  sudo ufw --force reset > /dev/null
  for (( i=0; i < ${#rules[@]}; i++ )) do
    if ! sudo ufw ${rules[i]} > /dev/null; then status_centinel=FAIL; fi
  done
  sudo ufw --force enable > /dev/null
  sudo ufw logging off > /dev/null

  # bookmark
  if [ $status_centinel = "OK" ]; then
    echo UFW_RULES_INSTALLED >> $SERVERET_PATH/cache_installed
    echo "DONE"
  else
    echo "FAIL"
  fi

fi
