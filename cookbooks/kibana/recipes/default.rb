kibana_owner = node['kibana']['owner']
kibana_group = node['kibana']['group']

name = "kibana-#{node['kibana']['version']}"
install_dir = node['kibana']['install_dir']
kibana_home = "#{install_dir}/#{name}"
archive_name = "#{name}.tar.gz"

user kibana_owner do
  action :create
  home kibana_home
end

group kibana_group do
  action :create
  members kibana_owner
  append true
end

remote_file "/tmp/#{archive_name}" do
  source node['kibana']['download_url']
  action :create_if_missing
end

execute 'extract kibana' do
  command "tar xvf /tmp/#{archive_name} -C #{install_dir}"
  not_if { ::File.exists?("#{kibana_home}") }
end

link "/#{install_dir}/kibana" do
  to "/#{kibana_home}"
end

full_path = "#{install_dir}/#{name}"

execute 'change ownership of the kibana directory' do
  command "chown -R #{kibana_owner}:#{kibana_group} #{kibana_home}"
end

execute 'change permissions of the kibana directory' do
  command "chmod -R 755 #{kibana_home}"
end

directory '/var/log/kibana' do
  owner kibana_owner
  group kibana_group
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
  variables(
    kibana_owner: kibana_owner,
    kibana_group: kibana_group
  )
end

service 'kibana' do
  action [ :enable, :start ]
end