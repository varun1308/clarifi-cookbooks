use_inline_resources

action :install do

	service_install_directory = "#{new_resource.service_install_base_path}\\#{new_resource.service_name}"

	#stop the service
	windows_service "#{new_resource.service_name}" do
	  action :stop
	  ignore_failure true
	end

	# Download the built application and unzip it to the app directory.
	windows_zipfile service_install_directory do
	  source new_resource.service_source
	  action :unzip
	  not_if { ::File.exists?(service_install_directory) }
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