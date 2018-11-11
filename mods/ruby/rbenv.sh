#! /bin/bash
# test: rbenv --help | grep global
echo "- mods/ruby/rbenv.sh"
git clone -q https://github.com/rbenv/rbenv.git ~/.rbenv
git clone -q https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo "" >> ~/.bashrc
echo "### SERVERET: rbenv ###" >> ~/.bashrc
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc