#
# Cookbook Name:: tavisca_apps
# Recipe:: iis_install
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

# Enable the IIS role.
dsc_script 'Web-Server' do
  code <<-EOH
  WindowsFeature InstallWebServer
  {
    Name = "Web-Server"
    Ensure = "Present"
  }
  EOH
end

# Install ASP.NET 4.5.
dsc_script 'Web-Asp-Net45' do
  code <<-EOH
  WindowsFeature InstallDotNet45
  {
    Name = "Web-Asp-Net45"
    Ensure = "Present"
  }
  EOH
end

# Install the IIS Management Console.
dsc_script 'Web-Mgmt-Console' do
  code <<-EOH
  WindowsFeature InstallIISConsole
  {
    Name = "Web-Mgmt-Console"
    Ensure = "Present"
  }
  EOH
end

# Remove the default web site.
include_recipe 'iis::remove_default_site'