# fix sources
execute "sed -i 's@http://us.@http://@g' /etc/apt/sources.list"

execute 'apt-get update'

%w(
  curl
  vim
  wget
).each do |to_install|
  package to_install
end