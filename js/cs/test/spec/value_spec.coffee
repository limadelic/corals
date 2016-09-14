describe 'Values (numbers, bools, strings ...)', ->

  values = [0, true, '42']

  it "default", -> _.each values, (x) ->
    corals(x).then().should.eql x

  describe 'Given', ->

    it 'value', ->
      _.each values, (original) ->
        _.each values, (value) ->
          corals original,
            { given: value }
            {
              when: value
              then: value
            }
          .then().should.eql value

  describe 'Whens', ->

    match = (outcome, context, _when) ->
      corals context, when: _when, then: outcome
      .then().should.eql outcome or context

    it 'value', -> _.each values, (x) ->
      match true, x, x
      match false, x, 42

    it 'array', -> _.each values, (x) ->
      match true, x, [x, 'more', 'stuff']
      match false, x, ['wat?', false]

    it 'fun', -> _.each values, (x) ->
      match true, x, -> x
      match false, x, -> 1

    it 'true fun', -> _.each values, (x) ->
      match true, x, -> true
      match false, x, -> false

    it 'this', -> _.each values, (x) ->
      match true, x, -> @

  describe 'Then', ->

    it 'value', -> _.each values, (x) ->
      corals 0, when: 0, then: x
      .then().should.eql x

    it 'fun', -> _.each values, (x) ->
      corals 0, { when: 0, then: -> x }
      .then().should.eql x

    it 'this', -> _.each values, (x) ->
      corals x, { when: x, then: -> @ }
      .then().should.eql x
