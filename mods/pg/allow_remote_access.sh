#! /bin/bash
this_file=mods/pg/allow_remote_access.sh

PG_CONF_FILE_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/data/postgresql.conf
HBA_CONF_FILE_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/data/pg_hba.conf

if grep -q POSTGRESQL_REMOTE_ADDRESS_ALLOWED $SERVERET_PATH/cache_installed; then
  echo "  OK $this_file"
elif ! grep -q POSTGRES_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "  * ERROR $this_file: install PostgreSQL first"
elif ! [ -w $HBA_CONF_FILE_PATH ]; then
  echo "  * ERROR $this_file: $HBA_CONF_FILE_PATH not found or not writable"
elif ! [ -w $PG_CONF_FILE_PATH ]; then
  echo "  * ERROR $this_file: $PG_CONF_FILE_PATH not found or not writable"
else

  # allow all addresses [postgresql.conf]
  echo -n "  * $this_file... "
  sed -i "s/#listen_addresses/listen_addresses/" $PG_CONF_FILE_PATH
  sed -i "s/listen_addresses = 'localhost'/listen_addresses = '*'/" $PG_CONF_FILE_PATH

  # allow access to $db_name using $db_user [pg_hba.conf] (idempotent)
  if ! grep -q "^host $db_name $USER 0.0.0.0/0 trust" $HBA_CONF_FILE_PATH; then
    echo "host all $USER 0.0.0.0/0 trust" >> $HBA_CONF_FILE_PATH
  fi

  # bookmark
  echo POSTGRESQL_REMOTE_ADDRESS_ALLOWED >> $SERVERET_PATH/cache_installed
  echo "DONE"

fi
