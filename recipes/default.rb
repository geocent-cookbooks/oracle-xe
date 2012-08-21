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

log "platform: #{node['platform']}"

case node['platform']
  when "windows"
    if File.exists?("C:\\Oracle\\OracleXE")
      Chef::Log.info("OracleXE install dir already exists.....not installing OracleXE")
    else
      template response_file do
        source "silent.xml.erb"
      end

      windows_package "Oracle 10g XE" do
        source remote_url
        options "/s /f1#{response_file} /f2#{log_file}"
        installer_type :installshield
        action :install
      end
    end

  when "centos"
    template "/tmp/responsefile" do
      source "responsefile"
    end

    installer = "/tmp/oracle-xe.rpm"

    remote_file installer do
      source remote_url
    end

    package "oracle-xe" do
      action :install
      source installer
      options "--nogpgcheck"
    end

    execute "oracle-xe" do
      command "/etc/init.d/oracle-xe configure < /tmp/responsefile >> /tmp/XEsilentinstall.log"
      action :run
      user "root"
    end
  end
