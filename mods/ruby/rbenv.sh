#! /bin/bash
this_file=mods/ruby/rbenv.sh

if grep -q RBENV_INSTALLED $cache_path; then
  echo "OK $this_file"
else

  # install rbenv and plugin
  echo -n "- $this_file... "
  git clone -q https://github.com/rbenv/rbenv.git ~/.rbenv
  git clone -q https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  # to make this module idempotent...
  if ! grep -q "### SERVERET: rbenv ###" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "### SERVERET: rbenv ###" >> ~/.bashrc
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    source ~/.bashrc
  fi

  # bookmark
  echo RBENV_INSTALLED >> $cache_path
  if rbenv --help | grep -q global; then 
    echo "DONE, CONFIRMED"
  else
    echo "FAIL"
  fi

fi
