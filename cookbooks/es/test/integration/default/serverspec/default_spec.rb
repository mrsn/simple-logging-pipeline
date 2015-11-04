require 'serverspec'

set :backend, :exec

describe file('/tmp/elasticsearch-1.5.1.deb') do
  it 'is a file' do
    expect(subject).to be_file
  end
end

describe file('/etc/init.d/elasticsearch') do
  it 'is a file' do
    expect(subject).to be_file
  end

  it 'has the right owner and group' do
    expect(subject).to be_owned_by('root')
    expect(subject).to be_grouped_into('root')
  end

  it 'has the right permissions' do
    expect(subject).to be_mode(755)
  end

  it 'has the right java options' do
    expect(subject).to contain('-XX:+UseParNewGC')
    expect(subject).to contain('-XX:+UseConcMarkSweepGC')
    expect(subject).to contain('-XX:CMSInitiatingOccupancyFraction=75')
    expect(subject).to contain('-XX:+UseCMSInitiatingOccupancyOnly')
    expect(subject).to contain('-XX:+HeapDumpOnOutOfMemoryError')
  end
end

describe file('/etc/elasticsearch/elasticsearch.yml') do
  it 'is a file' do
    expect(subject).to be_file
  end

  it 'has the right cluster name' do
    expect(subject).to contain('foo')
  end
end

describe 'ulimts are correct' do
end

describe 'service elasticsearch' do
  it { expect(service('elasticsearch')).to be_running }
end
