execute 'apt-get update'

%w(
  curl
  vim
  wget
).each do |to_install|
  package to_install
end