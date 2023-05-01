#!/bin/bash

echo "* Install Chef-workstation ..."
wget -P /tmp https://packages.chef.io/files/stable/chef-workstation/23.4.1032/el/8/chef-workstation-23.4.1032-1.el8.x86_64.rpm
rpm -Uvh /tmp/chef-workstation-23.4.1032-1.el8.x86_64.rpm
echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
echo 'export PATH="/opt/chef-workstation/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile

echo "* Chef generate repo ..."
chef generate repo chef-repo --chef-license accept
cd chef-repo/cookbooks
cp -r /vagrant/cookbooks/bgapp-db .

echo "* Run the recipe ..."
sudo chef-client --local-mode --runlist 'recipe[bgapp-db]'
