include_recipe 'java::openjdk'

package 'wget' do
  action :install
end

execute 'Download and install the public signing key' do
  command 'wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -'
end

execute 'Add the repository definition' do
  command "echo 'deb http://packages.elasticsearch.org/logstash/2.0/debian stable main' | sudo tee -a /etc/apt/sources.list"
end

directory '/etc/pki/tls/certs/' do
  action :create
  recursive true
end

directory '/etc/pki/tls/private' do
  action :create
  recursive true
end

execute 'apt-get update'

package 'logstash' do
  action :install
  version node['logstash']['version']
end

credentials = data_bag_item('logstash', 'credentials')

file('/etc/pki/tls/certs/logstash-forwarder.crt') do
  content credentials['certificate']
  notifies :restart, 'service[logstash]', :delayed
end

file('/etc/pki/tls/private/logstash-forwarder.key') do
  content credentials['private_key']
  notifies :restart, 'service[logstash]', :delayed
end

template '/etc/logstash/conf.d/01-lumberjack-input.conf' do
  source 'conf/01-lumberjack-input.conf.erb'
  notifies :restart, 'service[logstash]', :delayed
end

template '/etc/logstash/conf.d/10-syslog.conf' do
  source 'conf/10-syslog.conf.erb'
  notifies :restart, 'service[logstash]', :delayed
end

template '/etc/logstash/conf.d/30-lumberjack-output.conf' do
  source 'conf/30-lumberjack-output.conf.erb'
  notifies :restart, 'service[logstash]', :delayed
end

service 'logstash' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
