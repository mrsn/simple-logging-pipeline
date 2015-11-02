#
# Cookbook Name:: apt
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

execute 'Updating Packages' do
  command 'apt-get update'
end