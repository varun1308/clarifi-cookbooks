#
# Cookbook Name:: clarifi
# Recipe:: tmcui
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Create the app site.

#search for tmcui app
app = search(:aws_opsworks_app, "deploy:true").find {|x| x[:shortname] == "tmcui"}

if app
	Chef::Log.info "Found #{app[:shortname]} to deploy on the stack. Assuming tmcui app is same."

	tavisca_apps_website node['tmcui']['site_name'] do
	  host_header node['tmcui']['host_header']
	  port node['tmcui']['port']
	  protocol node['tmcui']['protocol']
	  website_base_directory node['tmcui']['website_base_directory']
	  runtime_version node['tmcui']['runtime_version']
	  scm app["app_source"]
	  action :add
	end
else
	Chef::Log.info "tmcui app not found in apps to deploy."
end