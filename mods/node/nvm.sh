#! /bin/bash
this_file=mods/node/nvm.sh

if grep -q NVM_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "OK $this_file"
else

  # install NVM
  echo -n "- $this_file v$nvm_version... "
  curl -s https://raw.githubusercontent.com/creationix/nvm/v$nvm_version/install.sh | bash > /dev/null 2>&1
  source ~/.nvm/nvm.sh

  # bookmark (or fail)
  if nvm --version | grep -q $nvm_version; then
    echo NVM_INSTALLED >> $SERVERET_PATH/cache_installed
    echo "DONE, CONFIRMED VERSION"
  else
    echo "FAIL"
  fi

fi
