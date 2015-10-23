#
# Cookbook Name:: clarifi
# Recipe:: tasks_winsvc
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

Chef::Log.level = :debug

apps = search(:aws_opsworks_app, "deploy:true") rescue []
app = apps.find {|x| x[:shortname] == "tasks_winsvc"}

if app
	Chef::Log.debug "Found #{app[:shortname]} to deploy on the stack. Assuming tmcui app is same."

	tavisca_apps_winservice node['tasks_winsvc']['service_name'] do
	  service_source node['tasks_winsvc']['service_source']
	  service_executable_with_args node['tasks_winsvc']['service_executable_with_args']
	  service_start node['tasks_winsvc']['service_start']
	  scm app["app_source"]
	  action :install		#action [:install, :start]
	end
	else
	Chef::Log.debug "tasks_winsvc app not found in apps to deploy."
end