use_inline_resources

action :add do
	
	website_directory = "#{new_resource.website_base_directory}\\#{new_resource.website_name}"
	
	app_pool_name = new_resource.website_name
	# Download the built application and unzip it to the app directory.

	local_dir = 'c:\\test'
	local_file = 'c:\\test\tmc.zip'

	directory  local_dir do
	  rights :read, 'IIS_IUSRS'
	  recursive true
	  action :create
	end
	app_checkout =  'c:\\test' #Chef::Config["file_cache_path"]

	Chef::Log.info "Downloading app source file using info #{new_resource.scm}."

	s3_file local_file do
        bucket 'varun-iis-cookbook'
        remote_path 'tmc.zip'
        s3_url 'https://s3-us-west-2.amazonaws.com/varun-iis-cookbook'
        aws_access_key_id new_resource.scm[:user]
        aws_secret_access_key new_resource.scm[:password]
        retries 2
      end


	# opsworks_scm_checkout new_resource.website_name do
	#     destination      app_checkout
	#     repository       new_resource.scm[:url]
	#     revision         new_resource.scm[:revision]
	#     user             new_resource.scm[:user]
	#     password         new_resource.scm[:password]
	#     ssh_key          new_resource.scm[:ssh_key]
	#     type             new_resource.scm[:type]
 #  	end

  		# Copy app to deployment directory
	execute "copy #{new_resource.website_name}" do
		command "Robocopy.exe #{app_checkout} #{website_directory} /MIR /XF .gitignore /XF web.config.erb /XD .git"
	end
	
	# Create the site app pool.
	iis_pool  new_resource.website_name do
	  runtime_version new_resource.runtime_version
	end

	# Create the site directory and give IIS_IUSRS read rights.
	directory website_directory do
	  rights :read, 'IIS_IUSRS'
	  recursive true
	  action :create
	end

	# Create the app site.
	iis_site new_resource.website_name do
	  protocol new_resource.protocol
	  port new_resource.port
	  path website_directory
	  application_pool new_resource.website_name
	  host_header new_resource.host_header
	  action [:add, :start]
	end	
end