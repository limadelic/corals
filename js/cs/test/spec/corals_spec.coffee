should = require 'should'

describe 'Corals', ->

  describe 'defaults', ->

    it 'undefined', ->
      should.not.exist corals().then()

    it 'defined', ->
      corals(42).then().should.eql 42

  describe 'Events', ->

    it 'empty', ->
      corals().events.should.be.empty()

    it 'one', ->
      corals 0, 1
      .events.should.eql [1]

    it 'two', ->
      corals 0, 1, 2
      .events.should.eql [1, 2]

    it 'many', ->
      corals 0, [1, 2, 42]
      .events.should.eql [1, 2, 42]

