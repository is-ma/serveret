#! /bin/bash
source ~/.serveret/serveret.conf

# test: just run and open ~/.bashrc to see changes
echo "- mods/bashrc/customized_aliases_and_rules.sh"
cat ~/.serveret/mods/bashrc/bashrc_customized.sh >> ~/.bashrc
