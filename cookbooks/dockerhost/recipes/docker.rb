#include_recipe "docker"
yum_package 'docker'

service "docker" do
  action :start
end

docker_group = node['docker']['group'] || 'docker'

group docker_group do
  members node['docker']['group_members']
  action [:create, :manage]
end
