require 'spec_helper'

describe 'logstash::default' do
  describe 'service logstash' do
    it { expect(service('logstash')).to be_running }
  end
end
