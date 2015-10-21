#
# Cookbook Name:: clarifi
# Recipe:: tmcui
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Create the app site.
tavisca_apps_website node['tmcui']['site_name'] do
  website_source node['tmcui']['site_source']
  host_header node['tmcui']['host_header']
  port node['tmcui']['port']
  protocol node['tmcui']['protocol']
  website_base_directory node['tmcui']['website_base_directory']
  runtime_version node['tmcui']['runtime_version']
  action :add
end