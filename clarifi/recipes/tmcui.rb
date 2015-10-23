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

	# resource 'x.txt' do
	#   rights :read, 'Everyone'
	#   rights :write, 'domain\group'
	#   rights :full_control, 'group_name_or_user_name'
	#   rights :full_control, 'user_name', :applies_to_children => true
	# end	

	file node['tmcui']['local_file'] do
	  rights :read, 'Everyone'
	  rights :full_control, 'Everyone'
	  action :create
	end

	::FileUtils.mv(node['tmcui']['local_file'], node['tmcui']['site_base_directory']+"\\TMC.zip", :verbose => true)


	# s3_file node['tmcui']['local_file']  do
 #        bucket 'varun-iis-cookbook'
 #        remote_path 'tmc.zip'
 #        s3_url 'https://s3-us-west-2.amazonaws.com/varun-iis-cookbook'
 #        aws_access_key_id app["app_source"][:user]
 #        aws_secret_access_key app["app_source"][:password]
 #    end

	# tavisca_apps_website node['tmcui']['site_name'] do
	#   host_header node['tmcui']['host_header']
	#   port node['tmcui']['port']
	#   protocol node['tmcui']['protocol']
	#   website_base_directory node['tmcui']['site_base_directory']
	#   runtime_version node['tmcui']['runtime_version']
	#   scm app["app_source"]
	#   action :add
	# end
else
	Chef::Log.info "tmcui app not found in apps to deploy."
end