describe 'Values (numbers, bools, strings ...)', ->

  values = [0, true, '42']

  it "default", -> _.each values, (x) ->
    corals(x).then().should.eql x

  describe 'Given', ->

    it 'value'

    it 'hash'

  describe 'Whens', ->

    match = (outcome, context, _when) ->
      corals context, when: _when, then: outcome
      .then().should.eql outcome or context

    it 'value', -> _.each values, (x) ->
      match true, x, x
      match false, x, 42

    it 'array', -> _.each values, (x) ->
      match true, x, [x, 1]
      match false, x, ['wat?', false]

    it 'func', -> _.each values, (x) ->
      match true, x, -> x
      match false, x, -> 1

    it 'this', -> _.each values, (x) ->
      match true, x, -> @

  describe 'Then', ->

    it 'value', ->
      corals 0, when: 0, then: true
      .then().should.be.true()

    it 'func'
    it 'this'
