#! /bin/bash
source ~/.serveret/serveret.conf

# test: ruby --version | grep $ruby_version
echo "- mods/ruby/ruby.sh v$ruby_version"

asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git > /dev/null 2>&1
echo "ruby $ruby_version" >> ~/.tool-versions
echo 'gem: --no-document' >> ~/.gemrc

asdf install > /dev/null 2>&1
