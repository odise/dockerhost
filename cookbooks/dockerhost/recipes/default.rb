case node['platform']
  when 'centos'
    if node['platform_version'].to_f > 6.9
      include_recipe "systemd::systemd"
    end
end

include_recipe "dockerhost::docker"

