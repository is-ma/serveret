#! /bin/bash
echo "- mods/isma/git_shortcuts.sh"
git clone -q https://github.com/is-ma/git_shortcuts.git ~/.git_shortcuts
echo "" >> ~/.bashrc
echo "### IS-MA: GIT SHORTCUTS ###" >> ~/.bashrc
echo "source ~/.git_shortcuts/git_shortcuts.sh" >> ~/.bashrc
source ~/.bashrc