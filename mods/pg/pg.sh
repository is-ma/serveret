#! /bin/bash
# test: psql --version | grep $pg_version
echo "- mods/pg/pg.sh v$pg_version"
sudo apt-get install -y build-essential > /dev/null 2>&1
asdf plugin-add postgres > /dev/null 2>&1
asdf install postgres $pg_version > /dev/null 2>&1
asdf global postgres $pg_version