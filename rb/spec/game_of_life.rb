require_relative '../lib/corals'

describe 'Game of Life' do

  subject { Corals.new [
    [],
    {
      when: { x:1, y:1},
      center?: true
    }
  ]}

  it 'Dead cell with 0 neighbors stays dead' do
    subject << {
      given: [
        [0,0,0],
        [0,0,0],
        [0,0,0]
      ],
      when: -> { center? },
      then: -> { expect(self).to be_dead }
    }
  end

end