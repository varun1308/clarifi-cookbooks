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
	Chef::Log.info "Found #{app[:shortname]} to deploy on the stack. Assuming tmcui app is same."

	s3_file node['tmcui']['website_base_directory'] + "\\" + node['tmcui']['site_name'] + "\\tmc.zip"  do
        bucket 'varun-iis-cookbook'
        remote_path 'tmc.zip'
        s3_url 'https://s3-us-west-2.amazonaws.com/varun-iis-cookbook'
        aws_access_key_id app["app_source"][:user]
        aws_secret_access_key app["app_source"][:password]
    end

	# tavisca_apps_website node['tmcui']['site_name'] do
	#   host_header node['tmcui']['host_header']
	#   port node['tmcui']['port']
	#   protocol node['tmcui']['protocol']
	#   website_base_directory node['tmcui']['website_base_directory']
	#   runtime_version node['tmcui']['runtime_version']
	#   scm app["app_source"]
	#   action :add
	# end
else
	Chef::Log.info "tmcui app not found in apps to deploy."
end