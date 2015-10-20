#
# Cookbook Name:: tmc
# Recipe:: deploy
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
# Define the local app and site locations.
Chef::Log.level = :debug
site_name = node['tmc']['site_name']
site_directory = 'C:\inetpub\sites\\' + site_name
site_source = node['tmc']['site_source']


app_pool_name = site_name
# Download the built application and unzip it to the app directory.
windows_zipfile site_directory do
  source site_source
  action :unzip
  not_if { ::File.exists?(site_directory) }
end

# Create the site app pool.
iis_pool  site_name do
  runtime_version '4.0'
  action :add
end

# Create the site directory and give IIS_IUSRS read rights.
directory site_directory do
  rights :read, 'IIS_IUSRS'
  recursive true
  action :create
end

# Create the app site.
iis_site site_name do
  protocol :http
  port 80
  path site_directory
  application_pool site_name
  host_header node['tmc']['host_header']
  action [:add, :start]
end
