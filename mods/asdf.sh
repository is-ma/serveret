# test: asdf --version | grep $asdf_version
echo "- asdf v$asdf_version"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v$asdf_version > /dev/null 2>&1
sudo apt-get install -y curl git > /dev/null 2>&1
cat << EOF >> ~/.bashrc
#
### SERVERET: ASDF ###
source ~/.asdf/asdf.sh
source ~/.asdf/completions/asdf.bash
EOF

source ~/.asdf/asdf.sh
source ~/.asdf/completions/asdf.bash
