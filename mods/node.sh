# test: node --version | grep $node_version
echo "- node v$node_version"

# install node
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git > /dev/null 2>&1
echo "nodejs $node_version" >> ~/.tool-versions
asdf install > /dev/null 2>&1

# be sure Phusion Passenger and Rails app could use the javascript runtime
sudo ln -sf /home/$USER/.asdf/installs/nodejs/$node_version/bin/node /usr/local/bin/node  # https://stackoverflow.com/a/42967056
