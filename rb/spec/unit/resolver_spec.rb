require 'spec_helper'

describe 'Resolver' do

  subject { Corals::Resolver.new }

  describe 'Load' do

    it 'load anonymous rules' do
      subject.rules = [{x:42}]
      subject.load
      expect(subject.rules.rules.first.x).to eq 42
    end

    it 'loads applicable rules'

  end

end