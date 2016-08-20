should = require 'should'

describe 'Corals', ->

  it 'is undefined', ->

    should.not.exist corals().then()

  it 'could be anything', ->

    corals(42).then().should.eql 42

  it 'could change', ->

    corals()
    .given 42
    .then().should.eql 42

  it 'remembers', ->

    corals [42, 2, true, 'that']
    .then().should.eql 'that'

  it 'it makes choices', ->

    corals when: 0, then: 'dead'
    .when(0).should.eql 'dead'
