#! /bin/bash
echo "- mods/isma/git_shortcuts.sh"
git clone https://github.com/is-ma/git_shortcuts.git ~/.git_shortcuts > /dev/null 2>&1
echo -e "\nsource ~/.git_shortcuts/git_shortcuts.sh" >> ~/.bashrc
source ~/.bashrc
