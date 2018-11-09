#! /bin/bash
PG_CONF_FILE_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/data/postgresql.conf
this_file=mods/pg/port.sh

if grep -q POSTGRES_PORT_SET_UP $cache_path; then
  echo "  OK $this_file"
elif ! grep -q POSTGRES_INSTALLED $cache_path; then
  echo "  * ERROR $this_file: you must install PostgreSQL first"
elif [ -z "$pg_port" ] || [ -z $pg_version ]; then
  echo "  * ERROR $this_file: pg_port|pg_version" 
elif ! [ -w $PG_CONF_FILE_PATH ]; then
  echo "  * ERROR $this_file: $PG_CONF_FILE_PATH not found or not writable"
else

  # set up Postgres port
  echo -n "  * $this_file... "
  sed -i "s/#port/port/" $PG_CONF_FILE_PATH
  sed -i "s/port = .*/port = $pg_port/" $PG_CONF_FILE_PATH

  # bookmark (or fail)
  if egrep -q "^port = $pg_port" $PG_CONF_FILE_PATH; then
    echo POSTGRES_PORT_SET_UP >> $cache_path
    echo "DONE, CONFIRMED"
  else
    echo "FAIL"
  fi

fi
