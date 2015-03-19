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
  source 'file:///' + node[:openidm][:path] + '/db/mysql/conf/repo.jdbc.json'
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

include_recipe 'openidm::mysql'

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
  action [:enable, :start]
end
