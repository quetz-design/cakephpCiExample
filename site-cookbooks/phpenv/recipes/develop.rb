#
# Cookbook Name:: phpenv
# Recipe:: develop
#
# Copyright 2015, Monolith Works, Inc.
#
# All rights reserved - Do Not Redistribute
#

hostsfile_entry '127.0.0.1' do
  hostname 'test.localhost'
  action :append
end

%w{php5-xdebug graphviz}.each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "/usr/local/bin/phpdoc" do
  source "http://www.phpdoc.org/phpDocumentor.phar"
  action :create_if_missing
  owner "root"
  group "root"
  mode 0755
end
