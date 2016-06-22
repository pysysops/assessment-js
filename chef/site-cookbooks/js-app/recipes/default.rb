#
# Cookbook Name:: js-app
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

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
