container_unit 'container-test' do
  depend "docker"
  image "odise/busybox-curl"
  command "/bin/sh -c 'while true; do echo xxx; sleep 2; done'"
  environment [
    "VAR1=VALUE1",
    "VAR2=VALUE2"
  ]
end

container_unit 'container-dependency' do
  depend "docker"
  image "odise/busybox-curl"
  link "--link container-test:test"
  ports "-p 8001:8001"
  command "/bin/sh -c 'while true; do echo zzz; sleep 2; done'"
end

container_unit 'container-test' do
  action :restart
end

container_unit 'container-dependency' do
  action :restart
end

#container_unit 'container-test' do
#  action :stop
#end

#container_unit 'container-dependency' do
#  action :remove
#end

case node['platform']

  # CENTOS 7
  when 'amazon', 'centos', 'fedora', 'redhat'

  # UBUNTU 14.04
  when 'debian', 'ubuntu'

    container_unit 'logspout' do
      depend "docker"
      volumes "-v /var/run/docker.sock:/tmp/docker.sock"
      ports "--publish=8000:8000"
      image "gliderlabs/logspout"
    end
end

