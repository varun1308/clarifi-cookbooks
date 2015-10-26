#
# Cookbook Name:: clarifi
# Recipe:: customers
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

#search for customers app
Chef::Log.level = :debug

apps = search(:aws_opsworks_app, "deploy:true") rescue []
app = apps.find {|x| x[:shortname] == "customers"}
if app
	Chef::Log.debug "Found #{app[:shortname]} to deploy on the stack. Assuming customers app is same."

	tavisca_apps_website node['customers']['site_name'] do
	  host_header node['customers']['host_header']
	  port node['customers']['port']
	  protocol node['customers']['protocol']
	  website_base_directory node['customers']['site_base_directory']
	  runtime_version node['customers']['runtime_version']
	  scm app["app_source"]
	  should_replace_web_config false
	  web_erb_config 'Web.config.erb'
	  web_config_params node['customers']["web_config_params"]
	  action :add
	end
else
	Chef::Log.debug "customers app not found in apps to deploy."
end

