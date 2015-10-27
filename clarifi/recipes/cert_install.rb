#
# Cookbook Name:: clarifi
# Recipe:: cert_install
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
Chef::Log.level = :debug

s3_file File.join(node["cert_install"]['local_dir'], node["cert_install"]['remote_path']) do
	bucket node["cert_install"]['bucket']
	remote_path node["cert_install"]['remote_path']
	s3_url node["cert_install"]['s3_url']
	aws_access_key_id node["cert_install"]['aws_access_key_id']
	aws_secret_access_key node["cert_install"]['aws_secret_access_key']
	owner 'root'
	group 'root'
	mode '0755'
	retries 2
end

execute "unzip #{node["cert_install"]['local_file']}" do
    command "unzip #{node["cert_install"]['local_file']}"
    cwd node["cert_install"]['local_dir']
end