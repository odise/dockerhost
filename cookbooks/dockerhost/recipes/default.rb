include_recipe "dockerhost::docker"

execute 'systemctl-daemon-reload' do
  command '/bin/systemctl --system daemon-reload'
  action :nothing
end

systemd_unit 'test.service' do
  execstart "/bin/true"
  execstop "/bin/true"
  deploypath "/tmp"
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
end
