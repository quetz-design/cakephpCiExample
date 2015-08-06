#
# Cookbook Name:: phpenv
# Recipe:: default
#
# Copyright 2015, Monolith Works, Inc.
#
# All rights reserved - Do Not Redistribute
#

%w{curl php5 php5-cli php5-fpm php5-mysql php-pear php5-curl php5-xsl php5-mcrypt mysql-server-5.5 nginx git}.each do |pkg|
  package pkg do
    action :install
  end
end

execute "php5enmod mcrypt" do
  action :run
end

service "apache2" do
  action [:disable, :stop]
  only_if "dpkg -l | grep apache2"
end

template "/etc/nginx/sites-available/test" do
  source "test.erb"
  owner "root"
  group "root"
  mode 0644
  action :create
  only_if { node['nginx']['test']['available'] == true }
end

link "/etc/nginx/sites-enabled/test" do
  to "/etc/nginx/sites-available/test"
  only_if { node['nginx']['test']['available'] == true }
end

template "/etc/nginx/sites-available/default" do
  source "default.erb"
  owner "root"
  group "root"
  mode 0644
  action :create
end

directory node['nginx']['docroot']['path'] do
  owner node['nginx']['docroot']['owner']
  group node['nginx']['docroot']['group']
  mode 0755
  action :create
  recursive true
  only_if { not File.exists?(node['nginx']['docroot']['path']) and node['nginx']['docroot']['force_create'] }
end

template "#{node['nginx']['docroot']['path']}/index.php" do
  source "index.php.erb"
  owner node['nginx']['docroot']['owner']
  group node['nginx']['docroot']['group']
  mode 0644
  action :create
  only_if { not File.exists?("#{node['nginx']['docroot']['path']}/index.php") and node['nginx']['docroot']['force_create'] }
end

service "nginx" do
  action [:enable, :restart]
end

service "mysql" do
  action [:enable, :restart]
  supports :status => true, :start => true, :stop => true, :restart => true
  not_if do File.exists?("/var/run/mysql/mysql.d.pid") end
end

execute "set_mysql_root_password" do
  command "/usr/bin/mysqladmin -u root password \"#{node['mysql']['root_password']}\""
  action :run
  only_if "/usr/bin/mysql -u root -e 'show databases;'"
end
