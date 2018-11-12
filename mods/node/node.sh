#! /bin/bash
# test: node --version | grep $node_version
echo "- mods/node/node.sh v$node_version"
nvm install $node_version > /dev/null 2>&1
nvm use $node_version > /dev/null 2>&1
sudo ln -sf /home/$USER/.nvm/versions/node/v$node_version/bin/node /usr/local/bin/node  # https://stackoverflow.com/a/42967056
