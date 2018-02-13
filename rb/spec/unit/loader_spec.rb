require 'spec_helper'

define loader: {
  require: [:stuff],
  defaults: :loader_defaults,
  rules: :loader_rules
}

define stuff: {
  defaults: :stuff_defaults,
  rules: :stuff_rules
}

describe 'Loader' do

  subject { Corals::Loader.new }

  it 'finds the dependent rules' do

    expect(subject.required [:loader]).to eq [:stuff, :loader]

  end

  it 'loads dependent rules' do

    rules, _ = subject.load [:loader]
    expect(rules).to eq [:stuff_rules, :loader_rules]

  end

  it 'loads default values' do

    _, defaults = subject.load [:loader]
    expect(defaults).to eq [:stuff_defaults, :loader_defaults]

  end

end