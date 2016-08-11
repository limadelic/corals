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