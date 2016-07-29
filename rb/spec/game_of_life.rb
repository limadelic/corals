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
        distance: -> (x, y) { delta(x.x, y.x) + delta(x.y, y.y) },
        is_neighbor?: -> (x) { distance(self, x) == 0 }
      },
      neighbors: -> { count is_neighbor? },
      center?: -> { distance(self, first) == distance(self, last) }
    },
    { when: -> { dead? and neighbors < 3 }, dead?: true },
    { when: -> { dead? and neighbors > 3 }, alive?: true }
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

  xit 'Dead cell with 1 neighbor stays dead' do

    subject << [
      0, 1, 0,
      0, 0, 0,
      0, 0, 0
    ]

    expect(center).to be_dead

  end

  xit 'Dead cell with 2 neighbors stays dead' do

    subject << [
      0, 1, 0,
      0, 0, 1,
      0, 0, 0
    ]

    expect(center).to be_dead

  end

  xit 'Dead cell with 3 neighbors comes to life' do

    subject << [
      0, 1, 0,
      0, 0, 1,
      0, 0, 0
    ]

    expect(center).to be_dead

  end

end