require 'serverspec'

set :backend, :exec

describe file('/usr/share/elasticsearch/plugins') do
  it 'is a directory' do
    expect(subject).to be_directory
  end
end

describe file('/usr/share/elasticsearch/bin/plugin') do
  it 'is a file' do
    expect(subject).to be_a_file
  end
end

describe file('/usr/share/elasticsearch/plugins/bigdesk') do
  it 'is a directory' do
    expect(subject).to be_directory
  end
end

describe file('/etc/elasticsearch/elasticsearch.yml') do
  it 'has the right aws credentials' do
    expect(subject).to contain('cloud.aws.access_key: 123')
    expect(subject).to contain('cloud.aws.secret_key: abc')
  end
end
