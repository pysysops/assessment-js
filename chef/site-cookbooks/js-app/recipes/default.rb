#
# Cookbook Name:: js-app
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'supervisor' do
  action :install
end

service 'supervisord' do
  action [ :enable, :start ]
end

# add the local repo (jenkins server)
yum_repository 'local-app' do
  description 'Local app repositpory'
  baseurl 'http://builds/'
  enabled true
  gpgcheck false
  action :create
end

package 'http-app' do
  action :install
end
