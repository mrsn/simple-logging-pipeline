default['kibana']['owner'] = 'kibana'
default['kibana']['group'] = 'kibana'
default['kibana']['version'] = '4.2.0-linux-x64'

default['kibana']['download_url'] = 
  "https://download.elastic.co/kibana/kibana/" +
  "kibana-#{node['kibana']['version']}.tar.gz"

default['kibana']['install_dir'] = "/opt"
default['kibana']['elasticsearch_url'] = 'http://192.168.33.51:9200'