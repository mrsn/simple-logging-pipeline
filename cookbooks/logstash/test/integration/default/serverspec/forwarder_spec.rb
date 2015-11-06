require 'spec_helper'

describe 'logstash::forwarder' do
  describe 'service logstash-forwarder' do
    it { expect(service('logstash-forwarder')).to be_running }
  end
end