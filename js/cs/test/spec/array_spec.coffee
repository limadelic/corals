describe 'Arrays', ->

  it 'core', ->
    corals([]).then().should.eql []

  describe 'Given', ->
  describe 'When', ->

    it 'value', ->
      corals([4, 42, 420]).when
        when: 42
        then: true
      .should.be.true()

    it 'array', ->
      corals([4, 42, 420]).when
        when: 42
        then: true
      .should.be.true()


  describe 'Then', ->
