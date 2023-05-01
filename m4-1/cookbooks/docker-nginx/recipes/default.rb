#Install docker
docker_installation 'default'

docker_service 'default' do
  action [:create, :start]
end

#Start Nginx container
docker_image 'nginx' do
    action :pull
  end
  
  docker_container 'nginx' do
    repo 'nginx'
    tag 'latest'
    port [ '8080:80' ]
    host_name 'www'
  end  

#Configure firewall
execute 'reconfigure firewall' do
    command "sudo firewall-cmd --zone=public --add-service=http --permanent"
  end

  execute 'restart firewall' do
    command "sudo firewall-cmd --reload"
  end

#
# Cookbook:: docker-nginx
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.
