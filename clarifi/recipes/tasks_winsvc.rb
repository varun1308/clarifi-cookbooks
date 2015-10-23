#
# Cookbook Name:: clarifi
# Recipe:: tasks_winsvc
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

Chef::Log.level = :debug
tavisca_apps_winservice node['tasks_winsvc']['service_name'] do
  service_source node['tasks_winsvc']['service_source']
  service_executable_with_args node['tasks_winsvc']['service_executable_with_args']
  service_start node['tasks_winsvc']['service_start']
  action :install		#action [:install, :start]
end