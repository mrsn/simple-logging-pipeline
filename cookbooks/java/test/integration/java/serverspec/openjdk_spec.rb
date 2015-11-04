require 'serverspec'

set :backend, :exec

%w(
  python-software-properties
  openjdk-7-jdk
).each do |package_name|
  describe package_name do
    it { expect(package(package_name)).to be_installed }
  end
end

describe 'java version' do
  it { expect(java_version).to include('1.7.0_85') }
end

def java_version
  command('java -version').stdout
end
