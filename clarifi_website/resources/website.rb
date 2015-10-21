actions :add
default_action :add

attribute :website_name, :name_attribute => true, :kind_of => String, :required => true
attribute :website_source, :kind_of => String
attribute :host_header, :kind_of => String
attribute :port, :kind_of => Fixnum, :default => 80
attribute :protocol, :kind_of => Symbol, :equal_to => [:http, :https],  :default => :http
attribute :website_base_directory, :kind_of => String, :default => "#{ENV['SYSTEMDRIVE']}\\inetpub\\wwwroot"

action :add do
	
	website_directory = "#{website_base_directory}\\#{website_name}"
	
	app_pool_name = website_name
	# Download the built application and unzip it to the app directory.
	windows_zipfile website_directory do
	  source website_source
	  action :unzip
	  not_if { ::File.exists?(website_directory) }
	end

	# Create the site app pool.
	iis_pool  website_name do
	  runtime_version '4.0'
	  action :add
	end

	# Create the site directory and give IIS_IUSRS read rights.
	directory website_directory do
	  rights :read, 'IIS_IUSRS'
	  recursive true
	  action :create
	end

	# Create the app site.
	iis_site website_name do
	  protocol protocol
	  port port
	  path website_directory
	  application_pool website_name
	  host_header host_header
	  action [:add, :start]
	end	
end