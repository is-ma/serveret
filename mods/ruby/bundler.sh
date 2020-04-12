#! /bin/bash
source ~/.serveret/serveret.conf

# test: bundler --version | grep $bundler_version
echo "- mods/ruby/bundler.sh v$bundler_version"
gem install bundler -v $bundler_version --no-ri --no-rdoc > /dev/null 2>&1
rbenv rehash