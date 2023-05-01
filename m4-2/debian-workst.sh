#!/bin/bash

echo "* Install Chef-workstation ..."
sudo apt-get update -y
wget -P /tmp https://packages.chef.io/files/stable/chef-workstation/23.4.1032/ubuntu/22.04/chef-workstation_23.4.1032-1_amd64.deb
sudo dpkg -i /tmp/chef-workstation_23.4.1032-1_amd64.deb
echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
echo 'export PATH="/opt/chef-workstation/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile

echo "* Chef generate repo ..."
chef generate repo chef-repo --chef-license accept
cd chef-repo/cookbooks
cp -r /vagrant/cookbooks/bgapp-web .

echo "* Run the recipe ..."
sudo chef-client --local-mode --runlist 'recipe[bgapp-web]'
