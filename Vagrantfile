
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Internal network range
PRIVATE_SUBNET="172.16.252"

nodes = {
  :nginx_proxy => {
    :hostname => "nginx-proxy",
    :ipaddress => "#{PRIVATE_SUBNET}.10",
    :run_list => [ "recipe[main::default]" ],
    :forwardport => {
      :guest => 80,
      :host => 8080
    }
  },
  :consul => {
    :hostname => "consul",
    :ipaddress => "#{PRIVATE_SUBNET}.15",
    :run_list => [ "recipe[main::default]" ]
  },
  :app_01 => {
    :hostname => "app-01",
    :ipaddress => "#{PRIVATE_SUBNET}.20",
    :run_list => [ "recipe[main::default]" ]
  },
  :app_02 => {
    :hostname => "app-02",
    :ipaddress => "#{PRIVATE_SUBNET}.21",
    :run_list => [ "recipe[main::default]" ]
  }
}

Vagrant.configure("2") do |config|

  # Use CentOS 7
  config.vm.box = "bento/centos-7.2"

  nodes.each do |node, options|
    config.vm.define node do |node_config|
      node_config.vm.network :private_network, ip: options[:ipaddress]
      if options.has_key?(:forwardport)
        node_config.vm.network :forwarded_port, guest: options[:forwardport][:guest], host: options[:forwardport][:host]
      end
      node_config.vm.hostname = options[:hostname]
      node_config.vm.provision :chef_zero do |chef|
        # Specify the local paths where Chef data is stored
        chef.cookbooks_path = "chef/cookbooks"
        chef.data_bags_path = "chef/data_bags"
        chef.roles_path = "chef/roles"
        chef.run_list = options[:run_list]
        chef.log_level = :warn
        # Or maybe a role
        #chef.add_role "web"
      end
    end
  end

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--memory", 512]
    vb.customize ["modifyvm", :id, "--cpus", 1]
  end
end
