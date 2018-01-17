p = (a) ->
  comb: (b) -> a * b
  inv: 1 - a
  xor: (b) -> a + b - @comb b


describe 'p', ->

  sut = p .5

  it 'comb', ->
    sut.comb .5
    .should.eql .25

  it 'inv', ->
    sut.inv.should.eql .5

  it 'xor', ->
    sut.xor .5
    .should.eql .75

