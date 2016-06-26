#
# Cookbook Name:: js-nginx
# Recipe:: proxy
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'js-nginx::default'

template '/etc/nginx/conf.d/nginx-proxy.conf' do
  source 'nginx-proxy.erb'
  mode '0644'
  owner 'root'
  group 'root'
  variables({
     :host => node['js-nginx']['proxy']['host'],
     :proxy_upstreams => node['js-nginx']['proxy']['upstreams']
  })
  notifies :reload, 'service[nginx]'
end
