require 'spec_helper'
require_relative 'corals/hello_world'

describe 'Hello World' do

  subject { resolve opts, [:hello_world] }

  let(:opts) {{}}

  it 'says hello' do
    opts[:name] = 'corals'
    expect(subject[:msg]).to eq 'Hello corals!'
  end

end