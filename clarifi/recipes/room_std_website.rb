#
# Cookbook Name:: clarifi
# Recipe:: room_std_website
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

Chef::Log.level = :debug

apps = search(:aws_opsworks_app, "deploy:true") rescue []
app = apps.find {|x| x[:shortname] == "room_std"}
if app
	Chef::Log.debug "Found #{app[:shortname]} to deploy on the stack. Assuming room_std app is same."

	tavisca_apps_website node['room_std_website']['site_name'] do
	  host_header node['room_std_website']['host_header']
	  port node['room_std_website']['port']
	  protocol node['room_std_website']['protocol']
	  website_base_directory node['room_std_website']['site_base_directory']
	  runtime_version node['room_std_website']['runtime_version']
	  scm app["app_source"]
	  action :add
	end
else
	Chef::Log.debug "room_std app not found in apps to deploy."
end