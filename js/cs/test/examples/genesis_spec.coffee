describe 'Create Game of Life',  ->

  sut = [
    0, 0, 0,
    0, 0, 0,
    0, 0, 0
  ]

  it 'nothing leads to nothing', ->

    corals(sut).then().should.eql sut

  it 'fake alive', ->

    corals sut, then: 1
    .then().should.eql [
      1, 1, 1,
      1, 1, 1,
      1, 1, 1
    ]
