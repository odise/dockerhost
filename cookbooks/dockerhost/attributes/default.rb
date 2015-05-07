default['docker']['package']['name'] = value_for_platform(
  'amazon' => {
    'default' => 'docker'
  },
  %w(centos redhat) => {
    %w(6.0 6.1 6.2 6.3 6.4 6.5 6.6) => 'docker-io',
    'default' => 'docker'
  },
  'fedora' => {
    'default' => 'docker-io'
  },
  'debian' => {
    'default' => 'lxc-docker'
  },
  'ubuntu' => {
    'default' => 'docker'
  },
  'default' => nil
)

default['docker']['group_members'] = value_for_platform(
  %w(centos redhat amazon) => {
    'default' => 'ec2-user'
  },
  'ubuntu' => {
    'default' => 'ubuntu'
  },
  'default' => nil
)

default['docker']['group'] = value_for_platform(
  %w(centos redhat) => {
    'default' => 'dockerroot'
  },
  %w(ubuntu amazon) => {
    'default' => 'docker'
  },
  'default' => nil
)
