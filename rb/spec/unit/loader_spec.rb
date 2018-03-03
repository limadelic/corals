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
    rules = subject.load [:dominoes]
    helper_rules = Corals::Rules::Helpers.rules

    helper_rules.each { |x| expect(rules).to include x }
  end

end