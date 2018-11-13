#! /bin/bash
# test: nvm --version | grep $nvm_version
echo "- mods/node/nvm.sh v$nvm_version"
curl -s https://raw.githubusercontent.com/creationix/nvm/v$nvm_version/install.sh | bash > /dev/null 2>&1
source ~/.nvm/nvm.sh