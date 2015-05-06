name 'dockerhost'
maintainer 'kreuzwerker GmbH'
maintainer_email 'jan.nabbefeld@kreuzwerker.de'
description 'Installs/Configures docker host settings'
#long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

depends 'docker'
depends 'sudo'
depends 'systemd'
depends 'container'

#%w(debian ubuntu).each do |os|
#  depends os
#end
