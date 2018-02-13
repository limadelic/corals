require 'spec_helper'

describe 'Resolver' do

  subject { Corals::Resolver.new }

  let(:opts) {{}}

  describe 'Default' do

    def default; subject.default opts, defaults end

    let(:defaults) {[{default: true}]}

    it 'are merged with opts' do
      expect(default[:default]).to be true
    end

    it 'dont override values' do
      opts[:default] = false
      expect(default[:default]).to be false
    end

    it 'goes deep' do
      defaults[0] = { default: defaults[0] }
      expect(default[:default][:default]).to be true
    end

  end

end