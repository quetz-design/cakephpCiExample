#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2015, Monolith Works, Inc.
#
# All rights reserved - Do Not Redistribute
#

apt_repository "jenkins" do
  uri "http://pkg.jenkins-ci.org/debian binary/"
  key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
  retries 10
  retry_delay 10
  action :add
end

package "jenkins" do
  action :install
end

service "jenkins" do
  action [:enable, :start]
end
