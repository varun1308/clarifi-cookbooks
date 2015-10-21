use_inline_resources

action :add do
	
	website_directory = "#{new_resource.website_base_directory}\\#{new_resource.website_name}"
	
	app_pool_name = new_resource.website_name
	# Download the built application and unzip it to the app directory.
	windows_zipfile website_directory do
	  source new_resource.website_source
	  action :unzip
	  not_if { ::File.exists?(website_directory) }
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