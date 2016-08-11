corals = require '../src/corals'

describe 'Numeric Corals', ->

  sut = corals 42

  it 'is a number', ->
    sut.then().should.eql 42

  it 'can change', ->
    sut.given -> @ + 1
      .then().should.eql 43