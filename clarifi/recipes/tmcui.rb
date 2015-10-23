#
# Cookbook Name:: clarifi
# Recipe:: tmcui
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Create the app site.

#search for tmcui app
Chef::Log.level = :debug

apps = search(:aws_opsworks_app, "deploy:true") rescue []
app = apps.find {|x| x[:shortname] == "tmc"}
if app
	Chef::Log.debug "Found #{app[:shortname]} to deploy on the stack. Assuming tmcui app is same."

	tavisca_apps_website node['tmcui']['site_name'] do
	  host_header node['tmcui']['host_header']
	  port node['tmcui']['port']
	  protocol node['tmcui']['protocol']
	  website_base_directory node['tmcui']['site_base_directory']
	  runtime_version node['tmcui']['runtime_version']
	  scm app["app_source"]
	  should_replace_web_config true
	  new_web_config 'Web.Prod.config'
	  action :add
	end
else
	Chef::Log.debug "tmcui app not found in apps to deploy."
end

