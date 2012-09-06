#
# Cookbook Name:: oracle-xe
# Recipe:: default
#
# Copyright 2012, Geocent
#
# All rights reserved - Do Not Redistribute
#
#

include_recipe "java"
include_recipe "oracle-xe"

db_zip = node['ch33-db']['zip']

case node['platform']
  when "windows"
    db_dir = "c:\\temp\\db"
    response_file = "#{db_dir}\\response"

    # Add XE listener

    cookbook_file "C:\\Oracle\\OracleXE\\app\\oracle\\product\\10.2.0\\server\\NETWORK\\ADMIN\\listener.ora" do
      source "ch33-listener.ora"
      inherits true
    end

    service "OracleXETNSListener" do
      action :restart
    end

    # Unzip database zip

    directory "#{db_dir}" do
      recursive true
      action :create
    end

    windows_zipfile db_dir do
      source db_zip
      overwrite true
      action :unzip
    end

    file response_file do
      content "y"
      action :create
    end

    execute "db-scorch" do
      command "database.scorch < #{response_file}"
      cwd db_dir
      returns [0,1]
      action :run
    end

    execute "db-update" do
      command "database.update < #{response_file}"
      cwd db_dir
      returns [0,1]
      action :run
    end
  end
