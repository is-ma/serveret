#! /bin/bash
# is not possible to use it on Vagrant (can't login as root)
this_file=mods/create_my_user.sh

if [ $USER != "root" ]; then
  echo "- ERROR $this_file: you're not root"
elif egrep -q "^$my_user:" /etc/passwd; then
  echo "OK $this_file"
elif [ -z "$root_pass" ] || [ -z "$my_user" ] || [ -z "$my_pass" ]; then
  echo "- ERROR $this_file: root_pass|my_user|my_pass"
else

  echo "- create a new user..."

  # create user '$my_user' with passwd '$my_pass'
  useradd -m -s /bin/bash $my_user > /dev/null 2>&1
  echo -e "$my_pass\n$my_pass" | passwd $my_user > /dev/null 2>&1

  # add user '$my_user' to sudo group; then to /etc/sudoers
  adduser $my_user sudo > /dev/null 2>&1
  if ! egrep -q "^$my_user\s" /etc/sudoers; then
    echo "$my_user ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo > /dev/null 2>&1
  fi

  # copy root SSH credentials to user '$my_user' (~/.ssh)
  cp -r ~/.ssh/ /home/$my_user/
  chown --recursive $my_user:$my_user /home/$my_user/.ssh

  # copy Serveret repo to /home/$my_user/serveret/
  cp -r ~/serveret/ /home/$my_user/
  chown --recursive $my_user:$my_user /home/$my_user/serveret

  # change root password to '$root_pass'
  echo -e "$root_pass\n$root_pass" | passwd root > /dev/null 2>&1

  # avoid root account to login again using terminal (security)
  sed -i "s/PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
  service ssh restart

fi
