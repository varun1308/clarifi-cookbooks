use_inline_resources

require 'fileutils'

action :add do
	
	website_directory = "#{new_resource.website_base_directory}\\#{new_resource.website_name}"
	
	app_pool_name = new_resource.website_name
	# Download the built application and unzip it to the app directory.

	app_checkout = Chef::Config["file_cache_path"] + "\\#{new_resource.website_name}"

	Chef::Log.debug "Downloading app source file using info #{new_resource.scm}."

	opsworks_scm_checkout new_resource.website_name do
	    destination      app_checkout
	    repository       new_resource.scm[:url]
	    revision         new_resource.scm[:revision]
	    user             new_resource.scm[:user]
	    password         new_resource.scm[:password]
	    ssh_key          new_resource.scm[:ssh_key]
	    type             new_resource.scm[:type]
  	end

  	#apply web.configchanges
  	#check if file needs to be replaced
  	if new_resource.should_replace_web_config && new_resource.new_web_config.empty? == false
  		
  		Chef::Log.debug "old web.config filepath: #{app_checkout}\\web.config"
  		#remove old web.config
  		# ::FileUtils.rm "#{app_checkout}\\web.config", :force => true

  		#move the new.web.config file to web.config
  		::FileUtils.mv "#{app_checkout}\\#{new_resource.new_web_config}", "#{app_checkout}\\web.config", { :force => true, :verbose => true }

  	elsif new_resource.web_erb_config.empty? == false #if erb file is defined
  		#apply template to create web.config
  		template "#{app_checkout}\\web.config" do
  		  local true
		  source "#{new_resource.web_erb_config}"
		  mode '0755'
		end
  	end

  	# Copy app to deployment directory

  	#delete destination dir
  	::FileUtils.rm_r "#{website_directory}", :force => true
  	#copy source dir to base dir
	::FileUtils.cp_r "#{app_checkout}", "#{new_resource.website_base_directory}"
	#delete source dir
  	::FileUtils.rm_r "#{app_checkout}", :force => true


	# execute "copy #{new_resource.website_name}" do
	# 	command "Robocopy.exe #{app_checkout} #{website_directory} /MIR /XF .gitignore /XF web.config.erb /XD .git"
	# end
	
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