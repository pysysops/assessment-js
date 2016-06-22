#
# Cookbook Name:: js-base
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# Assuming we are using only CentOS
include_recipe 'yum-epel'

# Add IPs to /etc/hosts for now to get MVP running
hosts = data_bag('hosts')

hosts.each do |hostentry|

  host = data_bag_item('hosts', hostentry)

  hostsfile_entry host['address'] do
    hostname  host['hostname']
    action    :create_if_missing
    aliases    host['aliases']
  end

end
