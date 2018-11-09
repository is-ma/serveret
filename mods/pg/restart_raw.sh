#! /bin/bash
this_file=mods/pg/restart_raw.sh

if ! [ -x ~/.asdf/shims/pg_ctl ]; then
  echo "  * ERROR $this_file: pg_ctl is not in place or is not executable: ~/.asdf/shims/pg_ctl"
elif [ -z "$pg_version" ]; then
  echo "  * ERROR $this_file: pg_version"
else

  # restart (raw output)
  echo -n "  * $this_file... "
  ~/.asdf/shims/pg_ctl -l ~/pg_log -D ~/.asdf/installs/postgres/$pg_version/data/ restart

fi
