#! /bin/bash
source ~/.serveret/serveret.conf

# test: asdf --version | grep $asdf_version
echo "- mods/pg/asdf.sh v$asdf_version"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v$asdf_version > /dev/null 2>&1
sudo apt-get install -y automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev > /dev/null 2>&1
echo "" >> ~/.bashrc
echo "### SERVERET: ASDF ###" >> ~/.bashrc
echo "source ~/.asdf/asdf.sh" >> ~/.bashrc
echo "source ~/.asdf/completions/asdf.bash" >> ~/.bashrc
source ~/.asdf/asdf.sh
source ~/.asdf/completions/asdf.bash