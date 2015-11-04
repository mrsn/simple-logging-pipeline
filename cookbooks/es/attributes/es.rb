default['es']['cluster_name'] = 'myprettycluster'
default['es']['version'] = '2.0.0'

default['es']['deb_filename'] = "elasticsearch" \
"-#{node['es']['version']}.deb"

default['es']['download_url'] = 
  'https://download.elasticsearch.org/' \
  'elasticsearch/release/org/elasticsearch/' \
  "distribution/deb/elasticsearch/#{node['es']['version']}/" +
  node['es']['deb_filename']

default['es']['download_path'] = "/tmp/#{node['es']['deb_filename']}"
default['es']['gc_settings'] =
"-XX:+UseParNewGC
-XX:+UseConcMarkSweepGC
-XX:CMSInitiatingOccupancyFraction=75
-XX:+UseCMSInitiatingOccupancyOnly
-XX:+HeapDumpOnOutOfMemoryError"
default['es']['heap_size'] = "#{(node.memory.total.to_i * 0.6).floor / 1024}m"
default['es']['jmx'] = false
