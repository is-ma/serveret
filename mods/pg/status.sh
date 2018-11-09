#! /bin/bash
if ! [ -x ~/.asdf/shims/pg_ctl ]; then
  echo "  * pg_ctl is not in place or is not executable: ~/.asdf/shims/pg_ctl"
else

  # start and output the status
  PG_STATUS=$(~/.asdf/shims/pg_ctl status | grep pg_ctl)
  echo "  * PosgtreSQL status... $PG_STATUS"

fi
