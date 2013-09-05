#
# Cookbook Name:: oracle_xe
# Recipe:: default
#
#
#


response_file = "#{Chef::Config['file_cache_path']}/responsefile"
installer_file = "#{Chef::Config['file_cache_path']}/oracle_xe.rpm"
log_file = node['oracle_xe']['log_file']

log "platform: #{node['platform']}"

case node['platform_family']
when "windows"
  if File.exists?("C:\\Oracle\\OracleXE")
    Chef::Log.info("OracleXE install dir already exists.....not installing OracleXE")
  else
    template response_file do
      source "responsefile.erb"
    end

    windows_package node['oracle_xe']['package_name'] do
      source node['oracle_xe']['remote_url']
      options "/s /f1#{response_file} /f2#{log_file}"
      installer_type :installshield
      action :install
    end
  end

when "centos", "rhel"

  include_recipe "oracle_xe::swapfile"

  template response_file do
    source "responsefile.erb"
  end

  remote_file installer_file do
    source node['oracle_xe']['remote_url']
  end

  package "oracle_xe" do
    action :install
    source installer_file
    provider Chef::Provider::Package::Rpm
  end

  execute "oracle_xe" do
    command "/etc/init.d/oracle-xe configure < #{response_file} >> #{log_file}"
    action :run
    user "root"
  end

when "debian", "ubuntu"

  include_recipe "oracle_xe::swapfile"

  template response_file do
    source "responsefile.erb"
  end

  remote_file installer_file do
    source node['oracle_xe']['remote_url']
  end

  package "oracle_xe" do
    action :install
    source installer_file
    provider Chef::Provider::Package::Dpkg
  end

  execute "oracle_xe" do
    command "/etc/init.d/oracle-xe configure < #{response_file}"
    action :run
    user "root"
  end

end
