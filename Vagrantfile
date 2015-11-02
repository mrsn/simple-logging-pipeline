# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "logstash" do |logstash|
    logstash.vm.box = "opscode_centos-7.1_chef-provisionerless"
    logstash.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-7.1_chef-provisionerless.box"
    logstash.omnibus.chef_version = :latest
    logstash.vm.network :private_network, ip: "192.168.33.10"

    logstash.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end

    #logstash.vm.provision :chef_solo do |chef|
    #  chef.cookbooks_path = "../../cookbooks"
    #  chef.data_bags_path = "../../data_bags"
    #  chef.log_level = :debug
    #  chef.add_recipe "cron"
    #  chef.add_recipe "backup-cookbook"
    #  chef.add_recipe "backup-cookbook::model"
    #  chef.add_recipe "deps"
    #  chef.add_recipe "zabbix::agent"
    #end
  end

  config.vm.define "graphite" do |graphite|
    graphite.vm.box = "opscode_centos-7.1_chef-provisionerless"
    graphite.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-7.1_chef-provisionerless.box"
    graphite.omnibus.chef_version = :latest
    graphite.vm.network :private_network, ip: "192.168.33.11"

    graphite.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end

    #graphite.vm.provision :chef_solo do |chef|
    #  chef.cookbooks_path = "../../cookbooks"
    #  chef.log_level = :debug
    #  chef.add_recipe "apt"
    #  chef.add_recipe "deps"
    #  chef.add_recipe "backup"
    #end
  end
end
