#
# Cookbook Name:: tmc
# Recipe:: deploy
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
# Define the local app and site locations.
require 'iis_website'

Chef::Log.level = :debug
site_name = node['tmc']['site_name']
site_source = node['tmc']['site_source']


# Create the app site.
iis_website_website site_name do
  website_source site_source
  action [:add]
end
