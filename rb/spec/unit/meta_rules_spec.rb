require 'spec_helper'
require_relative '../corals/dominoes'

describe 'Meta Rules' do

  it 'can be inferred' do

    expect(resolve({}, [:rules])[:rules]).to eq [:dominoes, :helpers]

  end

end