#! /bin/bash
echo "- mods/ack/ack.sh"
# test: ack -f
sudo apt-get install -y ack-grep > /dev/null 2>&1
cat ~/.serveret/mods/ack/bashrc_shortcuts.sh >> ~/.bashrc
