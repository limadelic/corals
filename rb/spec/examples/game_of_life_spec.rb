require 'spec_helper'
require_relative 'corals/game_of_life'

describe 'Game of Life' do

  xit 'dead cells should remain dead' do

    test :game_of_life,
      given: { cells: [
        0,0,0,
        0,0,0,
        0,0,0
      ]},
      then: { cells: [
        0,0,0,
        0,0,0,
        0,0,0
      ]}
  end

end