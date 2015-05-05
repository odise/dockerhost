
case node['platform']
  when 'amazon', 'centos', 'fedora', 'redhat'
    package node['docker']['package']['name']

    execute "enable and start docker" do
      command "systemctl enable docker && systemctl start docker"
    end

    execute "change group for docker.sock" do
      command "chgrp #{node['docker']['group']} /var/run/docker.sock"
    end

  when 'debian', 'ubuntu'
    package ['wget', 'inotify-tools']
    execute 'get docker.io' do
      command "wget -qO- https://get.docker.com/ | sh"
      not_if { ::File.exists?("/usr/bin/docker")}
    end

else
  fail "The package installation method for `#{node['platform']} is not supported.`"

end

service node['docker']['package']['name'] do
  action :start
end

docker_group = node['docker']['group'] || 'docker'

group docker_group do
  members node['docker']['group_members']
  action [:create, :manage]
end
