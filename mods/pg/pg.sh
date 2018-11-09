#! /bin/bash
this_file=mods/pg/pg.sh

if grep -q POSTGRES_INSTALLED $cache_path; then
  echo "OK $this_file"
elif ! grep -q ASDF_INSTALLED $cache_path; then
  echo "- ERROR $this_file: you must install ASDF first"
elif [ $USER == "root" ]; then
  echo "- ERROR $this_file: do not use root to to install PostgreSQL (with ASDF)"
elif [ -z "$pg_version" ]; then
  echo "- ERROR $this_file: pg_version"
else

  # install Postgres
  echo -n "- $this_file v$pg_version... "
  sudo apt-get install -y build-essential > /dev/null 2>&1
  asdf plugin-add postgres > /dev/null 2>&1
  asdf install postgres $pg_version > /dev/null 2>&1
  asdf global postgres $pg_version

  # bookmark (or fail)
  if psql --version | grep -q $pg_version; then
    echo POSTGRES_INSTALLED >> $cache_path
    echo "DONE, CONFIRMED VERSION"
  else
    echo "FAIL"
  fi

fi
