#! /bin/bash
source ~/.serveret/serveret.conf

# test: rails --version | grep $rails_version
echo "- mods/rails.sh v$rails_version"
# Ruby 2.6.0 removes the --ri and --rdoc options and their --no- variants,
# use --no-document instead or avoid it to configure any rails gem version.
gem install rails -v $rails_version > /dev/null 2>&1
rbenv rehash
