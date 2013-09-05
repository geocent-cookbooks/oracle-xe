
default['oracle_xe']['http_port'] = "8080"
default['oracle_xe']['listener_port'] = "1521"
default['oracle_xe']['admin_username'] = "oracle"
default['oracle_xe']['admin_password'] = "oracle"
default['oracle_xe']['start_on_boot'] = "y"
default['oracle_xe']['remote_url'] = nil
default['oracle_xe']['host'] = node['fqdn']

case node['platform_family']

when "debian", "ubuntu", "rhel", "fedora", "suse"
  default['oracle_xe']['log_file'] = "/tmp/oraclexe-install.log"
  default['oracle_xe']['server_home'] = "/usr/lib/oracle/xe/app/oracle/product/10.2.0/server"
when "mac_os_x", "mac_os_x_server"

when "windows"
  default['oracle_xe']['log_file'] = "C:/OracleXE-install.log"
  default['oracle_xe']['package_name'] = "Oracle 10g XE"
  default['oracle_xe']['server_home'] = "C:/Oracle/OracleXE/app/oracle/product/10.2.0/server"
end
