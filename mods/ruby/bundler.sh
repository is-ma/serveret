#! /bin/bash
this_file=mods/ruby/bundler.sh
if grep -q BUNDLER_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "OK $this_file"
elif ! grep -q RUBY_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "- ERROR $this_file: you must install Ruby first"
elif [ -z "$bundler_version" ]; then
  echo "- ERROR $this_file: bundler_version"
else

  # install Bundler
  echo -n "- $this_file v$bundler_version... "
  gem install bundler -v $bundler_version --no-ri --no-rdoc > /dev/null 2>&1
  rbenv rehash

  # bookmark (or fail)
  if bundler --version | grep -q $bundler_version; then
    echo BUNDLER_INSTALLED >> $SERVERET_PATH/cache_installed
    echo "DONE, CONFIRMED VERSION"
  else
    echo "FAIL"
  fi

fi
