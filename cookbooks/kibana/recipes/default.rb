user 'kibana'

group 'kibana' do
  action :create
  members ['kibana']
  append true
end

remote_file '/tmp/kibana-4.2.0-linux-x64.tar.gz' do
  source 'https://download.elastic.co/kibana/kibana/' \
    'kibana-4.2.0-linux-x64.tar.gz'
  action :create_if_missing
end

execute 'extract kibana' do
  command 'tar xvf /tmp/kibana-4.2.0-linux-x64.tar.gz -C /opt'
  not_if { ::File.exists?('/opt/kibana-4.2.0-linux-x64') }
end

link '/opt/kibana' do
  to '/opt/kibana-4.2.0-linux-x64'
end

execute 'change ownership of the kibana directory' do
  command "chown -R kibana:root /opt/kibana-4.2.0-linux-x64"
end

execute 'change permissions of the kibana directory' do
  command "chmod -R 755 /opt/kibana-4.2.0-linux-x64"
end

directory '/var/log/kibana' do
  owner 'kibana'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/init.d/kibana' do
  source 'kibana.erb'
  mode '0755'
end

template '/etc/default/kibana' do
  source 'default.erb'
  mode '0755'
end

service 'kibana' do
  action [ :enable, :start ]
end