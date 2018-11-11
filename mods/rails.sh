#! /bin/bash
# test: rails --version | grep $rails_version
echo "- mods/rails.sh v$rails_version"
gem install rails -v $rails_version --no-ri --no-rdoc > /dev/null 2>&1
rbenv rehash