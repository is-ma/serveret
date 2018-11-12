# Serveret
Serveret is a script tool to provision Ruby on Rails development/staging/production environments. It includes a running Rails app to show it works.



## Installation (Ubuntu 16.04.4 x64)

(ROOT ONLY) Create a user:
```
#! /bin/bash
my_user=deploy
my_pass=password    # choose one, won't be used for server access
root_pass=$my_pass  # choose one or same as my_pass; won't be used to login in

# test: grep "^$my_user:" /etc/passwd
useradd -m -s /bin/bash $my_user > /dev/null 2>&1
echo -e "$my_pass\n$my_pass" | passwd $my_user > /dev/null 2>&1

# test: grep "^$my_user\s" /etc/sudoers
adduser $my_user sudo > /dev/null 2>&1
echo "$my_user ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo > /dev/null 2>&1

# copy root SSH credentials to user '$my_user' (~/.ssh)
cp -r ~/.ssh/ /home/$my_user/
chown --recursive $my_user:$my_user /home/$my_user/.ssh

# change root password
echo -e "$root_pass\n$root_pass" | passwd root > /dev/null 2>&1

# avoid root login
sed -i "s/PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
service ssh restart

# login as my_user
su - $my_user
```

Prepare the system:
```
# Fix your locale
echo -e "LANG=en_US.UTF-8\nLANGUAGE=en_US.UTF-8\nLC_ALL=en_US.UTF-8" | sudo tee /etc/default/locale
exit  # log it again to apply (test with 'locale')

# Add serveret:
MY_HOME=$HOME; [ $USER == 'vagrant' ] && MY_HOME=/vagrant
cd $MY_HOME
git clone https://github.com/is-ma/serveret.git serveret/ --branch v3.0.0
cd serveret
```

## Customize Serveret
Open ```serveret.conf``` and customize it.

## It's time to provision
```
source $MY_HOME/main/provision.sh
```

## Tips
  - for many servers use names instead of IPs (/etc/hosts)
  - symlink environments: production.rb -> staging.rb
  - use main/deploy.sh from your dev machine (see below) to avoid using Capistrano
    * alias hour_app_staging='ssh deploy@host'
    * alias hour_app_staging_deploy=='ssh deploy@host . /home/deploy/serveret/main/deploy.sh'




# Support
Please [open an issue](https://github.com/is-ma/serveret/issues/new) for support.



# Contributing
Please contribute using [Github Flow](https://guides.github.com/introduction/flow/). Create a branch, add commits, and [open a pull request](https://github.com/is-ma/serveret/compare/).