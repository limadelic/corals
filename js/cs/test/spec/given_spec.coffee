describe 'Setup (given)', ->

  sut = corals 0

  it 'value', ->
    sut.given 42
    .then().should.eql 42

  it 'many values', ->
    sut.given 4, 42, 420
    .then().should.eql 420

  it 'array', ->
    sut.given [42, true, 'that']
    .then().should.eql 'that'
