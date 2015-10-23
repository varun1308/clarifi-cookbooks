use_inline_resources

action :install do

	service_install_directory = "#{new_resource.service_install_base_path}\\#{new_resource.service_name}"

	app_checkout = Chef::Config["file_cache_path"] + "\\#{new_resource.service_name}"
	
	#stop the service
	windows_service "#{new_resource.service_name}" do
	  action :stop
	  ignore_failure true
	end

	Chef::Log.debug "Downloading app source file using info #{new_resource.scm}."

	opsworks_scm_checkout new_resource.service_name do
	    destination      app_checkout
	    repository       new_resource.scm[:url]
	    revision         new_resource.scm[:revision]
	    user             new_resource.scm[:user]
	    password         new_resource.scm[:password]
	    ssh_key          new_resource.scm[:ssh_key]
	    type             new_resource.scm[:type]
  	end

  		# Copy app to deployment directory
	execute "copy #{new_resource.service_name}" do
		command "Robocopy.exe #{app_checkout} #{service_install_directory} /MIR /XF .gitignore /XF app.config.erb /XD .git"
	end

	powershell_script 'delete_if_exist' do
	  code <<-EOH
	     $Service = Get-WmiObject -Class Win32_Service -Filter "Name='#{new_resource.service_name}'"
	     if ($Service) {
	        $Service.Delete() 
	     }
	  EOH
	  notifies :run, "execute[Installing Service #{new_resource.service_name}]", :immediately
	end

	execute "Installing Service #{new_resource.service_name}" do
	  command "sc create \"#{new_resource.service_name}\" binPath= \"#{service_install_directory}\\#{new_resource.service_executable_with_args}\""
	  action :nothing
	end

	#configure startup
	windows_service "#{new_resource.service_name}" do
	  action :configure_startup
	  startup_type new_resource.service_start
	end
	
end

action :start do

	#start the service
	windows_service "#{new_resource.service_name}" do
	  action :start
	end
end