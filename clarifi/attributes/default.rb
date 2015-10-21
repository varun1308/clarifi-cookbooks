default['tmcui']['site_name'] = 'clarifi'
default['tmcui']['site_source'] = nil
default['tmcui']['host_header'] = 'tmc.clarifi.io'
default['tmcui']['port'] = 80
default['tmcui']['protocol'] = :http
default['tmcui']['site_base_directory'] = "#{ENV['SYSTEMDRIVE']}\\inetpub\\wwwroot"

default['room_std_website']['site_name'] = 'roomstd'
default['room_std_website']['site_source'] = nil
default['room_std_website']['host_header'] = 'room-std.clarifi.io'
default['room_std_website']['port'] = 80
default['room_std_website']['protocol'] = :http
default['room_std_website']['site_base_directory'] = "#{ENV['SYSTEMDRIVE']}\\inetpub\\wwwroot"

default['tasks_winsvc']['service_name'] = 'ContentManagementService'
default['tasks_winsvc']['service_source'] = nil
default['tasks_winsvc']['service_executable_with_args'] = 'Clarifi.ContentManagement.WinService.exe ,1,2,3,4,5,6,7,8,9,D,E,F,G,H,I,J,K,L,M'
default['tasks_winsvc']['service_start'] = :manual