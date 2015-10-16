#
# Cookbook Name:: tmc
# Recipe:: deploy
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
# Define the local app and site locations.
Chef::Log.level = :debug
query = Chef::Search::Query.new
app = query.search(:aws_opsworks_app, "type:other").first
app_name = app[0][:environment][:APP_NAME]
app_site_name = node['tmc']['app_site_name']
app_directory = 'C:\inetpub\apps\\' + app_site_name + '\\' + app_name
site_directory = 'C:\inetpub\sites\\' + app_site_name
app_source = app[0][:environment][:APP_ZIP_FILE_LOCATION]

app_pool_name = app_site_name + '_' + app_name
# Download the built application and unzip it to the app directory.
windows_zipfile app_directory do
  source app_source
  action :unzip
  not_if { ::File.exists?(app_directory) }
end

# Create the site app pool.
iis_pool  app_site_name do
  runtime_version '4.0'
  action :add
end
# Create the application app pool.
iis_pool  app_pool_name do
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
iis_site app_site_name do
  protocol :http
  port 80
  path site_directory
  application_pool app_site_name
  action [:add, :start]
end

# Create the app in the site.
iis_app app_site_name do
  application_pool app_pool_name
  path '/' + app_name
  physical_path app_directory
  action :add
end

