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