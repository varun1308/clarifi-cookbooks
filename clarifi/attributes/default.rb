default['cert_install']['local_dir'] = '/home/crt_dir/'
default['cert_install']['remote_path'] = 'certs.zip'
default['cert_install']['bucket'] = 'varun-iis-cookbook'
default['cert_install']['s3_url'] = 'https://s3-us-west-2.amazonaws.com/varun-iis-cookbook/'
default['cert_install']['aws_access_key_id'] = ''
default['cert_install']['aws_secret_access_key'] = ''

default['tmcui']['site_name'] = 'clarifi'
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

default['customers']['site_name'] = 'customers'
default['customers']['host_header'] = 'trip-smart.com'
default['customers']['port'] = 80
default['customers']['protocol'] = :http
default['customers']['site_base_directory'] = "#{ENV['SYSTEMDRIVE']}\\inetpub\\wwwroot"
