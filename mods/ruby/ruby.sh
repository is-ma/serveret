#! /bin/bash
# test: ruby --version | grep $ruby_version
echo -n "- mods/ruby/ruby.sh v$ruby_version"
sudo apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev > /dev/null 2>&1
rbenv install $ruby_version > /dev/null 2>&1
rbenv global $ruby_version