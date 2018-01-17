require 'spec_helper'
require_relative 'corals/hello_world'

describe 'Hello World' do

  it 'says hello' do
    expect(subject[:message]).to eq 'Hello corals!'
  end

end