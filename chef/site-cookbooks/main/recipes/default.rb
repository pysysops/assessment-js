#
# Cookbook Name:: main
# Recipe:: default
#

# Add IPs to /etc/hosts for now to get MVP running
hosts = data_bag('hosts')

hosts.each do |hostentry|

  host = data_bag_item('hosts', hostentry)

  hostsfile_entry host['address'] do
    hostname  host['hostname']
    action    :create_if_missing
  end

end
