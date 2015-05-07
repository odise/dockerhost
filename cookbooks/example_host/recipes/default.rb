#
# Cookbook Name:: cookbooks/example_host
# Recipe:: default
#
# Copyright (C) 2015 Jan Nabbefeld
#
# All rights reserved - Do Not Redistribute
#

Chef::Log.info("DEPLOY: #{node['deploy']}, OPSWORKS: #{node['opsworks']}")

# only deploy when short name of the application is set
if ( deploy? 'test_app' )

  container_unit 'container-test' do
    depend "docker"
    image "odise/busybox-curl"
    command "/bin/sh -c 'while true; do echo ${VAR1} and ${VAR2}; sleep 2; done'"
    environment [
      "VAR1=VALUE1",
      "VAR2=VALUE2"
    ]
  end

  container_unit 'container-dependency' do
    depend "docker"
    image "odise/busybox-curl"
    link "--link container-test:test"
    command "/bin/sh -c 'while true; do echo zzz; sleep 2; done'"
  end

  container_unit 'logspout' do
    depend "docker"
    volumes "-v /var/run/docker.sock:/tmp/docker.sock"
    ports "--publish=8000:8000"
    image "gliderlabs/logspout"
  end

  container_unit 'container-test' do
    action :restart
  end

  container_unit 'container-dependency' do
    action :restart
  end

  container_unit 'logspout' do
    action :restart
  end

end
