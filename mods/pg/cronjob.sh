#! /bin/bash
this_file=mods/pg/cronjob.sh

PG_CTL_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/bin/pg_ctl
PG_DATA_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/data/

if grep -q POSTGRES_CRONJOB_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "  OK $this_file"
elif ! [ -x $PG_CTL_PATH ]; then
  echo "  * ERROR $this_file: $PG_CTL_PATH not found"
elif ! [ -d $PG_DATA_PATH ]; then
  echo "  * ERROR $this_file: $PG_DATA_PATH not found"
else

  # install Postgres cronjob
  echo -n "  * $this_file... "
  (crontab -l 2>/dev/null; echo "@reboot $PG_CTL_PATH -l pg_log -D $PG_DATA_PATH start" | crontab -) > /dev/null

  # bookmark (or fail)
  if crontab -l | grep -q $PG_CTL_PATH; then
    echo POSTGRES_CRONJOB_INSTALLED >> $SERVERET_PATH/cache_installed
    echo "DONE, CONFIRMED"
  else
    echo "FAIL"
  fi

fi
