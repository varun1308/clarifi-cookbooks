#
# Cookbook Name:: clarifi
# Recipe:: room_std_website
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

tavisca_apps_website node['room_std_website']['site_name'] do
  website_source node['room_std_website']['site_source']
  host_header node['room_std_website']['host_header']
  port node['room_std_website']['port']
  protocol node['room_std_website']['protocol']
  website_base_directory node['room_std_website']['website_base_directory']
  runtime_version node['room_std_website']['runtime_version']
  action :add
end