#
# Cookbook Name:: oracle-xe
# Recipe:: default
#
# Copyright 2012, Geocent
#
# All rights reserved - Do Not Redistribute
#
remote_url = node['oracle-xe']['remote_url']
response_file = node['oracle-xe']['response_file']
log_file = node['oracle-xe']['log_file']

template response_file do
	source "silent.xml.erb"
end

windows_package "Oracle 10g XE" do
    source remote_url
    options "/s /f1#{response_file} /f2#{log_file}"
    installer_type :installshield
    action :install
end
