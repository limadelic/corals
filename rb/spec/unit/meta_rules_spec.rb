require 'spec_helper'
require_relative '../corals/dominoes'

describe 'Meta Rules' do

  it 'can be inferred' do

    expect(resolve({rules: [:dominoes], on: :play}, [:rules])[:rules])
      .to eq [:helpers, :dominoes, :play]

  end

end