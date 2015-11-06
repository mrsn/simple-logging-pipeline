execute 'Download and install the public signing key' do
  command 'wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch' \
    '| sudo apt-key add -'
end

# TODO: make this idempotent 
execute 'Add the repository definition' do
  command "echo 'deb http://packages.elastic.co/logstashforwarder/debian stable main'" \
    "| sudo tee /etc/apt/sources.list.d/logstashforwarder.list"
end

execute 'apt-get update'

package 'logstash-forwarder' do
  action :install
end

directory '/etc/pki/tls/certs' do
  action :create
  recursive true
end

cookbook_file '/etc/pki/tls/certs/logstash-forwarder.crt' do
  action :create
  source 'tls/certs/logstash-forwarder.crt'
  notifies :restart, 'service[logstash-forwarder]', :delayed
end

template '/etc/logstash-forwarder.conf' do
  source 'conf/logstash-forwarder.conf.erb'
  notifies :restart, 'service[logstash-forwarder]', :delayed
end

service 'logstash-forwarder' do
  action [:enable, :start]
end
