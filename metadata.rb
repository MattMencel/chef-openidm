name 'openidm'
maintainer 'Matt Mencel'
maintainer_email 'mr-mencel@wiu.edu'
license 'Apache 2.0'
description 'Installs/Configures openidm'
long_description 'Installs/Configures openidm'
version '0.3.2'

supports 'centos'

depends 'ark'
depends 'database'
depends 'java'
depends 'mysql', '~> 6.1.0'
depends 'mysql2_chef_gem'
depends 'mysql_connector', '~> 0.8.0'
