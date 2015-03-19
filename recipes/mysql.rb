chef_gem 'chef-vault'
require 'chef-vault'
item = ChefVault::Item.load('mysql', 'root')

mysql_service 'openidm' do
  version '5.6'
  initial_root_password item['password']
  action [:create, :start]
end

mysql2_chef_gem 'default' do
  action :install
end

mysql_connection_info = {
  host: 'localhost',
  username: 'root',
  password: item['password']
}

execute 'create_openidm_db' do
  command 'mysql -u root --password=' + item['password'] + ' '\
          '< ' + node[:openidm][:path] + '/db/mysql/scripts/openidm.sql'
  not_if { Dir.exist?('/var/lib/mysql-openidm/openidm') }
end

mysql_database_user node[:openidm][:db_user] do
  connection mysql_connection_info
  password node[:openidm][:db_pass]
  action [:create, :grant]
  database_name 'openidm'
  privileges [:all]
end
