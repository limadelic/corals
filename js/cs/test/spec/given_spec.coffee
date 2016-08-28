describe 'Setup (given)', ->

  sut = corals 0

  it 'value', ->
    sut.given 42
    .then().should.eql 42

  it 'array'
