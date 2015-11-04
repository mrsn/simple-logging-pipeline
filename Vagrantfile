# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.define "es" do |es|
    es.vm.box = "opscode_ubuntu-14.04_chef-provisionerless"
    es.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"
    es.omnibus.chef_version = :latest
    es.vm.network :private_network, ip: "192.168.33.51"

    es.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    es.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "es"
    end
  end

  config.vm.define "logstash" do |logstash|
    logstash.vm.box = "opscode_ubuntu-14.04_chef-provisionerless"
    logstash.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"
    logstash.omnibus.chef_version = :latest
    logstash.vm.network :private_network, ip: "192.168.33.50"

    logstash.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end

    logstash.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "logstash"
    #  chef.data_bags_path = "../../data_bags"
    end
  end
end
