describe 'Values (numbers, bools, strings ...)', ->

  values = [0, true, '42']

  it 'default', ->
    values.forEach (x) ->
      corals(x).then().should.eql x

  describe 'Given', ->

    it 'value'

    it 'hash'

  describe 'Whens', ->

    it 'value', ->
      corals 0, when: 0, then: true
      .then().should.be.true()
      corals 0, when: 1, then: true
      .then().should.eql 0

    it 'array'
    it 'lambda'
    it 'self'

  describe 'Then', ->

    it 'value', ->
      corals 0, when: 0, then: true
      .then().should.be.true()

    it 'lambda'
    it 'self'
