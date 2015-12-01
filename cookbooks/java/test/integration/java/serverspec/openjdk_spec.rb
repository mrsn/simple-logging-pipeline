require 'serverspec'

set :backend, :exec

%w(
  openjdk-7-jdk
).each do |package_name|
  describe package_name do
    it { expect(package(package_name)).to be_installed }
  end
end
