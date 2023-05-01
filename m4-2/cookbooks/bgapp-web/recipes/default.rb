#Install Apache and other packages
if node['platform_family'] == 'debian'
 vpackage = 'apache2'
else
 vpackage = 'httpd'
end
package 'Install Apache web server' do
 package_name "#{vpackage}"
end
service 'Start and Enable Apache web server' do
 service_name "#{vpackage}"
 action [ :enable, :start ]
end
package 'Install dependencies' do
  package_name [ "php", "php-mysqlnd" ]
end

#Copy files
cookbook_file '/var/www/html/index.php' do
  source 'index.php'
  mode '0755'
  owner 'root'
  group 'root'
  action :create
end
cookbook_file '/var/www/html/bulgaria-map.png' do
  source 'bulgaria-map.png'
  mode '0755'
  owner 'root'
  group 'root'
  action :create
end
file '/var/www/html/index.html' do
 action :delete
end

#
# Cookbook:: bgapp-web
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.
