# Serveret
Serveret is a script tool to provision Ruby on Rails development/staging/production environments. It includes a running Rails app example to show it works properly.

This installation works on Ubuntu 16.04.4 x64.

If your server is online (e.g. a DigitalOcean Droplet), chances are you have root access and you must start from **STEP 1**, otherwise you probably have a virtual machine (maybe using Vagrant) and you need to start with **STEP 2**.


## Installation

**STEP 1**: ROOT ONLY - Create a user (not on Vagrant)
```
#! /bin/bash
my_user=deploy
my_pass=password    # choose any, but won't be used for server access
root_pass=$my_pass  # won't be used to login in

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

**STEP 2**: Prepare the system.
```
# Fix your locale
echo -e "LANG=en_US.UTF-8\nLANGUAGE=en_US.UTF-8\nLC_ALL=en_US.UTF-8" | sudo tee /etc/default/locale
exit  # log it again to apply (test with 'locale')

# Log in again

# Add serveret:
MY_HOME=$HOME; [ $USER == 'vagrant' ] && MY_HOME=/vagrant
cd $MY_HOME
git clone https://github.com/is-ma/serveret.git serveret/ --branch v4.0.0
cd serveret
```

**STEP 3**: Customize Serveret.
Open ```serveret.conf``` with a text editor and customize it.

**STEP 4**: It's time to provision your software.
```
source main/provision.sh
```
Now put your server IP on a browser to see the example project.



## Tips

### Vagrantfile
Here is the Vagrantfile I use. For each VM I have, I increment the number on hostname and IPs (e.g. 10, 11, 12, ...), so there are no collisions between them and all the VM and my iMac can ping between them. So, it is very easy to simulate a lot machines for practicing scaling techniques on production without spending a single dollar.

Also, I don't need to use *forwarded_port* in Vagrantfile and have to see lots of addresses in my browser like *localhost:80* and *localhost:3000*, so it is pretty easy to know to wich VM I'm talking to just by watching the IPs on the browser 192.168.33.10 (Nginx listen on 80) or 192.168.33.10:3000.

*NOTE*: My iMac private IP is 192.168.10.10 and yes, it's a different network from the VMs, but Vagrant's magic configure all the networking for me behind the scenes just by doing ```vagrant up```.

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = '10-AppName'
  #config.disksize.size = "20GB"  # uses https://github.com/sprotheroe/vagrant-disksize
  config.vm.network "private_network", ip: "192.168.33.10"
  #config.vm.provider "virtualbox" do |vb|
  #  vb.memory = "2048"
  #end
end
```

### Development
For ```rails server``` to work, it isn't required to stop Nginx, but you need to install missing gems and databases:
  - ```bundle install --with development --no-deployment```
  - ```RAILS_ENV=development rails db:create   # first time only```
  - ```RAILS_ENV=development rails db:migrate```
  - ```RAILS_ENV=development rails db:seed     # first time only```
  - Use 192.168.33.10:3000 to load the app.

### General
  - If you have many servers, it's easier to use names instead of IPs (/etc/hosts).
  - In Rails, symlink your environments: production.rb -> staging.rb (DRY).
  - Use ```main/deploy.sh``` from your dev machine (see below) to avoid using Capistra-noise:
    * ```alias hour_app_staging='ssh deploy@host'```
    * ```alias hour_app_staging_deploy='ssh deploy@host . /home/deploy/serveret/main/deploy.sh'```



# Support
Please [open an issue](https://github.com/is-ma/serveret/issues/new) for support.



# Contributing
Please contribute using [Github Flow](https://guides.github.com/introduction/flow/). Create a branch, add commits, and [open a pull request](https://github.com/is-ma/serveret/compare/).
