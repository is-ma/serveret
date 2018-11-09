#! /bin/bash
if ! [ -x ~/.asdf/shims/pg_ctl ]; then
  echo "  * pg_ctl is not in place or is not executable: ~/.asdf/shims/pg_ctl"
else

  # start and output the status
  ~/.asdf/shims/pg_ctl -m fast stop > /dev/null
  source ~/serveret/mods/pg/status.sh

fi
