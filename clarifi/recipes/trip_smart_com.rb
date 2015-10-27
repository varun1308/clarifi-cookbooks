#
# Cookbook Name:: clarifi
# Recipe:: trip_smart_com
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

Chef::Log.level = :debug

apps = search(:aws_opsworks_app, "deploy:true") rescue []
app = apps.find {|x| x[:shortname] == "tripsmart"}
if app
	Chef::Log.debug "Found #{app[:shortname]} to deploy on the stack. Assuming tripsmart app is same."

	tavisca_apps_website node['tripsmart']['site_name'] do
	  host_header node['tripsmart']['host_header']
	  port node['tripsmart']['port']
	  protocol node['tripsmart']['protocol']
	  website_base_directory node['tripsmart']['site_base_directory']
	  runtime_version node['tripsmart']['runtime_version']
	  scm app["app_source"]
	  should_replace_web_config false
	  web_erb_config 'Web.config.erb'
	  web_config_params node['tripsmart']["web_config_params"]
	  action :add
	end
else
	Chef::Log.debug "tripsmart app not found in apps to deploy."
end

