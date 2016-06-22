#
# Cookbook Name:: js-nginx
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'nginx'  do
  action :install
end

cookbook_file '/etc/nginx/nginx.conf' do
  source 'nginx.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'service[nginx]'
end

service 'nginx' do
  action [ :enable, :start ]
end

directory '/var/www' do
  owner 'nginx'
  group 'nginx'
  mode '0755'
  action :create
end

directory '/var/www/html' do
  owner 'nginx'
  group 'nginx'
  mode '0755'
  action :create
end
