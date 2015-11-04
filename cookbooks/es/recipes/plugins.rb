# TODO: Rewrite this with LWRP 
es_plugin_bin = node['es']['plugin_dir_bin']
es_plugin_dir = node['es']['plugin_dir']

install_cmd = "#{es_plugin_bin} install "

node['es']['plugin'].each do |plugin_name, opts|
  execute "installing plugin #{plugin_name} with #{opts['version']}" do
    command install_cmd +
      "#{opts['namespace']}/#{plugin_name}/#{opts['version']}"
    not_if { ::File.exist?("#{es_plugin_dir}/plugin_name") }
  end
end
