# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define :test_ubuntu do |test_ubuntu|
    test_ubuntu.vm.hostname = "test-ubuntu"
    test_ubuntu.vm.box = "opscode_ubuntu-12.04_provisionerless"
    test_ubuntu.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"
    test_ubuntu.vm.network :private_network, ip: "33.33.33.21"
    test_ubuntu.omnibus.chef_version = "11.4.0"

    test_ubuntu.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end

    test_ubuntu.vm.provision :chef_solo do |chef|

      chef.json = {
        :oracle_xe => {
          :remote_url => 'http://33.33.33.1:8000/oracle-xe-universal_10.2.0.1-1.0_i386.deb',
        }
      }

      chef.data_bags_path = "data_bags"
      chef.run_list = [
        "recipe[apt]",
        "recipe[oracle_xe]"
      ]
    end
  end

  config.vm.define :test_centos do |box|
    box.vm.hostname = "test-centos"
    box.vm.box = "opscode_centos-5.9_chef-11.4.0.box"
    box.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_centos-5.9_chef-11.4.0.box"
    box.vm.network :private_network, ip: "33.33.33.21"
    #box.omnibus.chef_version = "11.4.0"
    box.vm.network :forwarded_port, guest: 8080, host:8085
    box.vm.network :forwarded_port, guest: 1521, host:1521

    box.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end

    box.vm.provision :chef_solo do |chef|

      chef.json = {
        :oracle_xe => {
          :remote_url => 'http://33.33.33.1:8000/oracle-xe-10.2.0.1-1.0.i386.rpm',
        }
      }

      chef.data_bags_path = "data_bags"
      chef.run_list = [
        "recipe[yum]",
        "recipe[oracle_xe]"
      ]
    end
  end



end
