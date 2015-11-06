require 'spec_helper'

version = '4.2.0-linux-x64'
kibana_owner = 'kibana'

describe user('kibana') do
  it { should exist }
end

describe user('kibana') do
  it { should belong_to_group 'kibana' }
end

describe file("/tmp/kibana-#{version}.tar.gz") do
  it 'is a file' do
    expect(subject).to be_file
  end
end

describe file('/var/log/kibana') do
  it 'is a directory' do
    expect(subject).to be_directory
  end

  it 'has the right ownership' do
    expect(subject).to be_owned_by kibana_owner
  end

  it 'has the right permissions' do
    expect(subject).to be_mode 755
  end
end

describe file("/opt/kibana-#{version}") do
  it 'is a directory' do
    expect(subject).to be_directory
  end

  it 'has the right ownership' do
  	expect(subject).to be_owned_by kibana_owner
  end

  it 'has the right permissions' do
    expect(subject).to be_mode 755
  end
end

describe file('/opt/kibana') do
  it 'is a symbolic link' do
    expect(subject).to be_symlink
  end
end

%w(
  /etc/init.d/kibana
  /etc/default/kibana
).each do |f|
  describe file(f) do
    it 'is a file' do
      expect(subject).to be_file
    end
  
    it 'has the right permission' do
      expect(subject).to be_mode 755
    end

    it 'has the right ownership' do
      expect(subject).to be_owned_by 'root'
      expect(subject).to be_grouped_into 'root'
    end
  end
end

describe file('/etc/default/kibana') do
  its(:content) { should match /user=\"kibana\"/ }
  its(:content) { should match /group=\"kibana\"/ }
end

describe 'service kibana' do
  it { expect(service('kibana')).to be_running }
end