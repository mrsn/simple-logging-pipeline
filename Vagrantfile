# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

box_name = 'opscode_ubuntu-14.04_chef-provisionerless'

box_url = 'http://opscode-vm-bento.s3.amazonaws.com/' \
  "vagrant/virtualbox/#{box_name}.box"

omnibus_chef_version = '12.5.1'

$script = <<SCRIPT

sed -i 's@http://us.@http://@g' /etc/apt/sources.list

SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.provision "shell", inline: $script

    config.vm.define 'es' do |es|
    es.vm.box = box_name
    es.vm.box_url = box_url
    es.omnibus.chef_version = omnibus_chef_version
    es.vm.network :private_network, ip: '192.168.33.51'

    es.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '1024', '--cpus', '2']
    end

    es.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = 'cookbooks'
      chef.add_recipe 'base'
      chef.add_recipe 'es'
      chef.add_recipe 'kibana'
    end
  end

  config.vm.define 'logstash' do |logstash|
    logstash.vm.box = box_name
    logstash.vm.box_url = box_url
    logstash.omnibus.chef_version = omnibus_chef_version
    logstash.vm.network :private_network, ip: '192.168.33.50'

    logstash.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    logstash.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = 'cookbooks'
      chef.add_recipe 'base'
      chef.add_recipe 'logstash'
    #  chef.data_bags_path = "../../data_bags"
    end
  end

  config.vm.define 'shipper' do |shipper|
    shipper.vm.box = box_name
    shipper.vm.box_url = box_url
    shipper.omnibus.chef_version = omnibus_chef_version
    shipper.vm.network :private_network, ip: '192.168.33.49'

    shipper.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    shipper.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = 'cookbooks'
      chef.add_recipe 'base'
      chef.add_recipe 'logstash::forwarder'
    #  chef.data_bags_path = "../../data_bags"
    end
  end
end
