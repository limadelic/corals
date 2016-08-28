should = require 'should'

describe 'Corals', ->

  it 'undefined', ->
    should.not.exist corals().then()

  it 'default', ->
    corals(42).then().should.eql 42
