#! /bin/bash
this_file=mods/pg/pg.sh

if grep -q POSTGRES_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "OK $this_file"
elif ! grep -q ASDF_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "- ERROR $this_file: install ASDF first"
elif [ $USER == "root" ]; then
  echo "- ERROR $this_file: do not use root to to install PostgreSQL (with ASDF)"
else

  # install Postgres
  echo -n "- $this_file v$pg_version... "
  sudo apt-get install -y build-essential > /dev/null 2>&1
  asdf plugin-add postgres > /dev/null 2>&1
  asdf install postgres $pg_version > /dev/null 2>&1
  asdf global postgres $pg_version

  # bookmark (or fail)
  if psql --version | grep -q $pg_version; then
    echo POSTGRES_INSTALLED >> $SERVERET_PATH/cache_installed
    echo "DONE, CONFIRMED VERSION"
  else
    echo "FAIL"
  fi

fi
