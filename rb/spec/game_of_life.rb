require_relative '../lib/corals'

describe 'Game of Life' do

  subject { Corals.new [
    []
  ]}

  def center; subject[4] end

  it 'Dead cell with 0 neighbors stays dead' do

    subject << [
      0,0,0,
      0,0,0,
      0,0,0
    ]

    expect(center).to be_dead

  end

end