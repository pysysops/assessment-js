#
# Cookbook Name:: main
# Recipe:: jenkins
#

# deps for builds
include_recipe 'golang'
python_runtime '2'
python_package 'jenkins-job-builder'

include_recipe 'jenkins::java'
include_recipe 'jenkins::master'

# Useful plugins
jenkins_plugin 'greenballs'
jenkins_plugin 'git'

# Base job to update jobs
xml = File.join(Chef::Config[:file_cache_path], 'cookbooks/main/files/default/jjb-update.xml')
jenkins_job 'jjb-update' do
  config xml
end
