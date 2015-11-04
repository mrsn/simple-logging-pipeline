include_recipe 'java::openjdk'

download_url = node['es']['download_url']
download_path = node['es']['download_path']

remote_file download_path do
  source download_url
  action :create_if_missing
end

dpkg_package 'elasticsearch' do
  source download_path
end

template '/etc/init.d/elasticsearch' do
  source 'elasticsearch.erb'
  owner 'root'
  group 'root'
  mode 0755
  variables(
    es_heap_size: node['es']['heap_size'],
    gc_settings: node['es']['gc_settings'],
    jmx: node['es']['jmx']
  )
end

template '/etc/elasticsearch/elasticsearch.yml' do
  source 'elasticsearch.yml.erb'
  owner 'root'
  group 'elasticsearch'
  mode 0640
  variables(
    cluster_name: node['es']['cluster_name']
  )
  notifies :restart, 'service[elasticsearch]', :immediately 
end

service 'elasticsearch' do
  action [:enable, :start]
end
