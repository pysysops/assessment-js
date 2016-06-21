#
# Cookbook Name:: main
# Recipe:: jenkins
#

# deps for builds
include_recipe 'golang'
python_runtime '2'
python_package 'jenkins-job-builder'

package 'Install rpm-build' do
  case node[:platform]
  when 'redhat', 'centos'
    package_name 'rpm-build'
  end
end

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

include_recipe 'jenkins::java'
include_recipe 'jenkins::master'

# Useful plugins
plugins = [ 'git', 'greenballs' ]

plugins.each do |plugin|
  jenkins_plugin plugin do
    notifies :restart, 'service[jenkins]'
  end
end

# Base job to update jobs
xml = File.join(Chef::Config[:file_cache_path], 'cookbooks/main/files/default/jjb-update.xml')
jenkins_job 'jjb-update' do
  config xml
end
