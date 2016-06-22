#
# Cookbook Name:: js-jenkins
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# deps for builds
include_recipe 'golang'
python_runtime '2'
python_package 'jenkins-job-builder'

build_packages = [ 'rpm-build', 'createrepo', 'pssh', 'ansible' ]
build_packages.each do |build_package|
  package build_package do
    action :install
  end
end

node.set['jenkins']['master']['install_method'] = 'package'
include_recipe 'jenkins::java'
include_recipe 'jenkins::master'

directory '/etc/jenkins_jobs' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/jenkins_jobs/jenkins_jobs.ini' do
  source 'jenkins_jobs.ini'
  owner 'root'
  group 'jenkins'
  mode '0640'
  action :create
end

# Useful plugins
plugins = [ 'git', 'greenballs', 'copyartifact', 'artifactdeployer', 'ws-cleanup' ]

plugins.each do |plugin|
  jenkins_plugin plugin do
    notifies :restart, 'service[jenkins]'
  end
end

# Base job to update jobs - Could / should template this
xml = File.join(Chef::Config[:file_cache_path], 'cookbooks/js-jenkins/files/default/jjb-update.xml')
jenkins_job 'jjb-update' do
  config xml
end
