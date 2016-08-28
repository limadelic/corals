
corals = require '../../src/corals'

describe 'Game of Life', ->

  sut = corals [
    []
    {
      given:
        dead: -> when: 0
        alive: -> when: 1
    }
    {
      given: size: -> Math.sqrt count
      x: -> @ / size
      y: -> @ % size
    }
    {
      given:
        delta: (x,y) -> (x - y) ** 2
        distance: (other) -> _.max delta(x, other.x), delta(y, other.y)
        is_neighbor: (other) -> 1 is distance other

      neighbors: -> count is_neighbor
    }
    {
      given:
        in_solitude: -> neighbors < 2
        overpopulated: -> neighbors > 3
        could_spawn: -> neighbors is 3

      dead: -> alive and (in_solitude or overpopulated)
      alive: -> dead and could_spawn
    }
  ]

  it.skip 'Dead cell with 0 neighbors stays dead', ->

    sut.given [

      [0, 0, 0,
       0, 0, 0,
       0, 0, 0]

      when: -> center
      then: -> @dead.should.be.true()
    ]
