#
# Cookbook Name:: openidm
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe 'java'

ark 'openidm' do
  url node[:openidm][:url]
  version node[:openidm][:version]
  path '/opt/openidm-' + node[:openidm][:version]
  home_dir node[:openidm][:path]
end

# Setup Steps for OpenIDM with MySQL
# http://openidm.forgerock.org/doc/install-guide/index.html#repository-mysql

mysql_connector_j node[:openidm][:path] + '/bundle/'

file node[:openidm][:path] + '/conf/repo.orientdb.json' do
  action :delete
end

remote_file node[:openidm][:path] + '/conf/repo.jdbc.json' do
  source 'file:///' + node[:openidm][:path] + '/db/mysql/conf/repo.jdbc.json.erb'
  action :create_if_missing
end

{ 'username' => node[:openidm][:db_user],
  'password' => node[:openidm][:db_pass]
}.each_pair do |k, v|
  openidm_repo_edit node[:openidm][:path] + '/conf/repo.jdbc.json' do
    action :edit_connection
    file 'repo.jdbc.json'
    key k
    value v
  end
end

include_recipe 'mysql::server'

include_recipe 'database::mysql'
mysql_connection_info = {
  host: 'localhost',
  username: 'root',
  password: node[:mysql][:server_root_password]
}

execute 'create_openidm_db' do
  command 'mysql -u root --password=' + node[:mysql][:server_root_password] + ' -D '\
  'openidm < ' + node[:openidm][:path] + '/db/mysql/scripts/openidm.sql'
  not_if { Dir.exist?(node[:mysql][:data_dir] + '/openidm') }
end

mysql_database_user node[:openidm][:db_user] do
  connection mysql_connection_info
  password node[:openidm][:db_pass]
  action [:create, :grant]
  database_name 'openidm'
  privileges [:all]
end

execute 'create_openidm_rc' do
  command node[:openidm][:path] + '/bin/create-openidm-rc.sh'
  cwd node[:openidm][:path] + '/bin'
  not_if { ::File.exist?(node[:openidm][:path] + '/bin/openidm') }
end

remote_file '/etc/init.d/openidm' do
  source 'file:///' + node[:openidm][:path] + '/bin/openidm'
  action :create
  mode '0755'
  only_if { ::File.exist?(node[:openidm][:path] + '/bin/openidm') }
end

service 'openidm' do
  supports :restart => true
  action [ :enable, :start ]
end
