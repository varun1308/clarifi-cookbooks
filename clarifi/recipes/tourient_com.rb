#
# Cookbook Name:: clarifi
# Recipe:: tourient_com
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

#search for tourient app
Chef::Log.level = :debug

apps = search(:aws_opsworks_app, "deploy:true") rescue []
app = apps.find {|x| x[:shortname] == "tourient"}
if app
	Chef::Log.debug "Found #{app[:shortname]} to deploy on the stack. Assuming tourient app is same."

	tavisca_apps_website node['tourient']['site_name'] do
	  host_header node['tourient']['host_header']
	  port node['tourient']['port']
	  protocol node['tourient']['protocol']
	  website_base_directory node['tourient']['site_base_directory']
	  runtime_version node['tourient']['runtime_version']
	  scm app["app_source"]
	  should_replace_web_config false
	  web_erb_config 'Web.config.erb'
	  web_config_params node['tourient']["web_config_params"]
	  action :add
	end
else
	Chef::Log.debug "tourient app not found in apps to deploy."
end

