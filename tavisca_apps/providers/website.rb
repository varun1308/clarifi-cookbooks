use_inline_resources

action :add do
	
	website_directory = "#{new_resource.website_base_directory}\\#{new_resource.website_name}"
	
	app_pool_name = new_resource.website_name
	# Download the built application and unzip it to the app directory.

	app_checkout = ::File.join(Chef::Config["file_cache_path"], new_resource.website_name)

	opsworks_scm_checkout new_resource.website_name do
	    destination      app_checkout
	    repository       new_resource.scm.url
	    revision         new_resource.scm.revision
	    user             new_resource.scm.username
	    password         new_resource.scm.password
	    ssh_key          new_resource.scm.ssh_key
	    type             new_resource.scm.type
  	end

  		# Copy app to deployment directory
	execute "copy #{new_resource.website_name}" do
		command "Robocopy.exe #{app_checkout} #{website_directory} /MIR /XF .gitignore /XF web.config.erb /XD .git"
	end

	# unzip file commented
	=begin
	windows_zipfile website_directory do
	  source new_resource.website_source
	  action :unzip
	  not_if { ::File.exists?(website_directory) }
	end
	=end

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