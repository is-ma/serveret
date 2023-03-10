#! /bin/bash
source ~/.serveret/serveret.conf

# test: psql --version | grep $pg_version
echo "- mods/pg/pg.sh v$pg_version"
sudo apt-get install -y linux-headers-$(uname -r) build-essential libssl-dev libreadline-dev zlib1g-dev libcurl4-openssl-dev uuid-dev icu-devtools > /dev/null 2>&1
asdf plugin-add postgres > /dev/null 2>&1
echo "postgres $pg_version" > ~/.tool-versions
asdf install > /dev/null 2>&1
