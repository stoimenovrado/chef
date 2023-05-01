#Install and configure mariaDB
package 'Install MariaDB server and dependencies' do
  package_name [ "mariadb", "mariadb-server" ]
end

service 'mariadb' do
  action [:start, :enable]
end

cookbook_file "/tmp/db_setup.sql" do
  source "db_setup.sql"
  mode "0755"
end

execute 'initialize db' do
  command "mysql -u root < /tmp/db_setup.sql"
end

#Configure firewall
execute 'reconfigure firewall' do
  command "sudo firewall-cmd --add-port=3306/tcp --permanent"
end

execute 'restart firewall' do
  command "sudo firewall-cmd --reload"
end

#
# Cookbook:: bgapp-db
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.
