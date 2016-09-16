describe 'Values (numbers, bools, strings ...)', ->

  sut = [0, true, '42']

  it 'core', -> _.each sut, (x) ->
    corals(x).then().should.eql x

  describe 'Given', ->

    verify = (given) -> _.each sut,(x) -> _.each sut,(y) ->
      corals x,
        { given: given y }
        { when: y, then: y }
      .then().should.eql y

    it 'value', -> verify (x) -> x
    it 'fun', -> verify (x) -> x
    it 'array', -> verify (x) -> [x, 'and', 'stuff']
    it.skip 'fun', -> verify (x) -> -> x

  describe 'Whens', ->

    match = (outcome, context, _when) ->
      corals context, when: _when, then: outcome
      .then().should.eql outcome or context

    it 'value', -> _.each sut, (x) ->
      match true, x, x
      match false, x, 42

    it 'array', -> _.each sut, (x) ->
      match true, x, [x, 'more', 'stuff']
      match false, x, ['wat?', false]

    it 'fun', -> _.each sut, (x) ->
      match true, x, -> x
      match false, x, -> 1

    it 'true fun', -> _.each sut, (x) ->
      match true, x, -> true
      match false, x, -> false

    it 'this', -> _.each sut, (x) ->
      match true, x, -> @

  describe 'Then', ->

    it 'value', -> _.each sut, (x) ->
      corals 0, when: 0, then: x
      .then().should.eql x

    it 'fun', -> _.each sut, (x) ->
      corals 0, { when: 0, then: -> x }
      .then().should.eql x

    it 'this', -> _.each sut, (x) ->
      corals x, { when: x, then: -> @ }
      .then().should.eql x
