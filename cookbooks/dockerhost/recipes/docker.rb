case node['platform']
  when 'amazon', 'centos', 'fedora', 'redhat'
    package node['docker']['package']['name']

  when 'debian', 'ubuntu'
    %w{wget tmux nmap}.each do |pkg|
      package pkg
    end
    execute 'get docker.io' do
      command "wget -qO- https://get.docker.com/ | sh"
      not_if { ::File.exists?("/usr/bin/docker")}
    end

else
  fail "The package installation method for `#{node['platform']} is not supported.`"

end

# XXX: make docker daemon restart in systemd unit script for centos
service node['docker']['package']['name'] do
  action [:enable, :start]
end

docker_group = node['docker']['group'] || 'docker'

group docker_group do
  members node['docker']['group_members']
  action [:create, :manage]
end
