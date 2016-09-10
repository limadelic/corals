should = require 'should'

describe 'Corals', ->

    it 'undefined', ->
      should.not.exist corals().then()

    it 'defined', ->
      corals(42).then().should.eql 42

    it 'empty', ->
      corals().corals.should.be.empty()

    it 'one', ->
      corals 0, 1
      .corals.should.eql [1]

    it 'two', ->
      corals 0, 1, 2
      .corals.should.eql [1, 2]

    it 'many', ->
      corals 0, [1, 2, 42]
      .corals.should.eql [1, 2, 42]

    it 'many of many', ->
      corals 0, [[1, 2]], [{}, 42], {x: true}
      .corals.should.eql [[[1, 2]], [{}, 42], {x: true}]