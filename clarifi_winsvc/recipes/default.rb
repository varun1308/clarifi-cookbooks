#
# Cookbook Name:: clarifi_website
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

Chef::Log.level = :debug
site_name = node['clarifi_website']['site_name']
site_source = node['clarifi_website']['site_source']


# Create the app site.
clarifi_website_website site_name do
  website_source site_source
  action :add
end
