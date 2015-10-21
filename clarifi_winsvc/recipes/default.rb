#
# Cookbook Name:: clarifi_winsvc
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

Chef::Log.level = :debug
site_name = node['tmc']['site_name']
site_source = node['tmc']['site_source']


# Create the app site.
clarifi_winsvc_website site_name do
  website_source site_source
  action :add
end
