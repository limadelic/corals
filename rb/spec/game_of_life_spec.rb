require 'spec_helper'
require_relative '../lib/corals'

describe 'Game of Life' do

  subject { Corals.new [
    [],
    { when: 0, dead?: true },
    { when: 1, alive?: true },
    {
      given: { size: -> { Math.sqrt count }},
      x: -> { self / size },
      y: -> { self % size }
    },
    {
      given: {
        delta: -> (x, y) { (x - y) ** 2 },
        distance: -> (other) { [delta(x, other.x), delta(y, other.y)].max },
        is_neighbor?: -> (other) { distance(other) == 1  }
      },
      neighbors: -> { count is_neighbor? },
    },
    {
      given: {
        in_solitude?: -> { neighbors < 2 },
        overpopulated?: -> { neighbors > 3 },
        could_spawn?: -> { neighbors == 3 }
      },
      dead?: -> { alive? && (in_solitude? || overpopulated?) },
      alive?: -> { dead? && could_spawn? }
    }
  ]}

  it 'Dead cell with 0 neighbors stays dead' do

    subject << {
      given: [
        0, 0, 0,
        0, 0, 0,
        0, 0, 0
      ],
      when: -> { center? },
      then: -> { expect.to be_dead }
    }

  end

end