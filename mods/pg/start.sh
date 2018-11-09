#! /bin/bash
this_file=mods/pg/start.sh

if ! [ -x ~/.asdf/shims/pg_ctl ]; then
  echo "  * ERROR $this_file: pg_ctl is not in place or is not executable: ~/.asdf/shims/pg_ctl"
elif [ -z "$pg_version" ]; then
  echo "  * ERROR $this_file: pg_version"
elif source ~/serveret/mods/pg/status.sh | grep -q PID; then
  echo "  OK $this_file"
else

  # start and output the status
  echo -n "  * $this_file... "
  ~/.asdf/shims/pg_ctl -l ~/pg_log -D ~/.asdf/installs/postgres/$pg_version/data/ start > /dev/null

  # test and tell
  if source ~/serveret/mods/pg/status.sh | grep -q PID; then
    echo "DONE, CONFIRMED"
  else
    echo "FAIL"
  fi

fi
