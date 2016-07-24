require_relative '../lib/corals'

describe 'Game of Life' do

  subject { Corals.new [
    { cells: [] },
    {
      cells: {
        when: { x:1, y:1},
        center?: true
    }}
  ]}

  it 'Dead cell with 0 neighbors stays dead' do
    subject(
      given: {
        cells:[
          [0,0,0],
          [0,0,0],
          [0,0,0]
        ]},
      cells: {
        when: -> { center? },
        then: -> { expect(it).to be_dead }
      }
    )
  end

end