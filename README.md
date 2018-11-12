# Serveret
Serveret is a script tool to provision Ruby on Rails development/staging/production environments.



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
exit  # log it again to apply

# Add serveret:
GO_HOME=$HOME && [ $USER == 'vagrant' ] && GO_HOME=/vagrant && cd $GO_HOME
git clone https://github.com/is-ma/serveret.git serveret/ --branch v2.0.0
cd serveret
```

# customize serveret.conf
Open ```serveret.conf``` and customize it.

# it's time to provision
source main/provision.sh
```

# Try deploying using a script:
```
source $GO_HOME/serveret/main/deploy.sh
```

Alias deploy script from your dev machine:
```
# examples
alias hour_app_staging='ssh deploy@host'
alias hour_app_staging_deploy=='ssh deploy@host . /home/deploy/serveret/main/deploy.sh'
```



## Tips
  - add database.yml / secrets.yml / master.key to .gitignore
  - for many servers use names instead of IPs (/etc/hosts)
  - symlink environments: production.rb -> staging.rb



## Support
Please [open an issue](https://github.com/is-ma/serveret/issues/new) for support.



## Contributing
Please contribute using [Github Flow](https://guides.github.com/introduction/flow/). Create a branch, add commits, and [open a pull request](https://github.com/is-ma/serveret/compare/).