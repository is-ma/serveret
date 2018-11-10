#! /bin/bash
this_file=mods/ruby/ruby.sh

if grep -q RUBY_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "OK $this_file"
elif ! grep -q RBENV_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "- ERROR $this_file: you must install rbenv first"
elif [ -z "$ruby_version" ]; then
  echo "- ERROR $this_file: ruby_version"
else

  # install Ruby (the idempotent way)...
  echo -n "- $this_file v$ruby_version... "
  sudo apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev > /dev/null 2>&1
  if ! ls ~/.rbenv/versions/ | grep -q "$ruby_version"; then
    rbenv install $ruby_version > /dev/null 2>&1
    rbenv global $ruby_version
  fi

  # bookmark (or fail)
  if ruby --version | grep -q $ruby_version; then
    echo RUBY_INSTALLED >> $SERVERET_PATH/cache_installed
    echo "DONE, CONFIRMED VERSION"
  else
    echo "FAIL"
  fi

fi
