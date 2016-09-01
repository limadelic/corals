describe 'Values (numbers, bools, strings ...)', ->

  values = [0, true, '42']

  it 'default', ->
    values.forEach (x) ->
      corals(x).then().should.eql x

  describe 'Given', ->

    it 'value'

    it 'hash'

  describe 'Whens', ->

    match = (outcome, context, _when) ->
      corals context, when: _when, then: outcome
      .then().should.eql outcome or context

    it 'value', ->
      match true, 0, 0
      match false, 0, 1

    it 'array', ->
      match true, 0, [0, 1]
      match false, 0, [1, 2]

    it 'lambda'
    it 'self'

  describe 'Then', ->

    it 'value', ->
      corals 0, when: 0, then: true
      .then().should.be.true()

    it 'lambda'
    it 'self'
