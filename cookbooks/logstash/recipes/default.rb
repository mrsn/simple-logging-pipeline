#
# Cookbook Name:: logstash
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'wget' do
  action :install
end

execute 'Download and install the public signing key' do
  command 'wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -'
end

execute 'Add the repository definition' do
  command "echo 'deb http://packages.elasticsearch.org/logstash/2.0/debian stable main' | sudo tee -a /etc/apt/sources.list"
end

execute 'apt-get update'

package 'logstash' do
  action :install
end