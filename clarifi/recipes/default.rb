#
# Cookbook Name:: clarifi
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

Chef::Log.level = :debug
include_recipe 'tavisca_apps::iis_install'
include_recipe 'tmcui'
include_recipe 'roomstd'