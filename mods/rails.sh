#! /bin/bash
this_file=mods/rails.sh

if grep -q RAILS_INSTALLED $cache_path; then
  echo "OK $this_file"
elif ! grep -q BUNDLER_INSTALLED $cache_path; then
  echo "- ERROR $this_file: you must install Bundler first"
elif ! grep -q NODE_INSTALLED $cache_path; then
  echo "- ERROR $this_file: you must install Node first"
elif [ -z "$rails_version" ]; then
  echo "- ERROR $this_file: rails_version"
else

  # install Rails
  echo -n "- $this_file v$rails_version... "
  gem install rails -v $rails_version --no-ri --no-rdoc > /dev/null 2>&1
  rbenv rehash

  # bookmark (or fail)
  if rails --version | grep -q $rails_version; then
    echo RAILS_INSTALLED >> $cache_path
    echo "DONE, CONFIRMED VERSION"
  else
    echo "FAIL"
  fi

fi
