#
# Cookbook Name:: js-jenkins
# Recipe:: yumrepo
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

directory '/var/www/html/repo' do
  owner 'jenkins'
  group 'nginx'
  mode '0755'
  action :create
end
