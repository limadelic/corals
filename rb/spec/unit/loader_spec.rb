require 'spec_helper'
require_relative '../corals/dominoes'

define dominoes: {
  require: [:helpers]
}

describe 'Loader' do

  subject { Corals::Loader.new }

  it 'finds the dependent rules' do

    expect(subject.required [:dominoes]).to eq [:helpers, :dominoes]

  end

  it 'loads dependent rules' do

    rules, _ = subject.load [:dominoes]
    expect(rules).to eq Corals::Rules::Helpers.rules

  end

  it 'loads default values' do

    _, defaults = subject.load [:dominoes]
    expect(defaults.first.keys).to eq [:dominoes, :table, :players]

  end

end