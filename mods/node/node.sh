#! /bin/bash
this_file=mods/node/node.sh

if grep -q NODE_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "OK $this_file"
elif ! grep -q NVM_INSTALLED $SERVERET_PATH/cache_installed; then
  echo "- ERROR $this_file: you must install NVM first"
elif [ -z "$node_version" ]; then
  echo "- ERROR $this_file: node_version" 
else

  # install Node
  echo -n "- $this_file v$node_version... "
  nvm install $node_version > /dev/null 2>&1
  nvm use $node_version > /dev/null 2>&1
  sudo ln -sf /home/deploy/.nvm/versions/node/v$node_version/bin/node /usr/local/bin/node

  # bookmark (or fail)
  if node --version | grep -q $node_version; then
    echo NODE_INSTALLED >> $SERVERET_PATH/cache_installed
    echo "DONE, CONFIRMED_VERSION"
  else
    echo "FAIL"
  fi

fi
