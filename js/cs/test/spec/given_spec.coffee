describe 'Given', ->
# It's got 2 uses static/dynamic
# static: builds up the chain of events
# dynamic: used to keep temp/helper info

  describe 'Static', ->
  # It's used to append events
  # does not lead to a conclusion
  # just appends to the events

    sut = {}

    beforeEach (done) ->
      sut = corals 0
      done()

    it 'value', ->

      sut.given 42
      .then().should.eql 42

      sut.corals.should.eql [42]

    it 'many values', ->

      sut.given 4, 42, 420
      .then().should.eql 420

      sut.corals.should.eql [4, 42, 420]

    it 'array', ->

      sut.given [42, true, 'that']
      .then().should.eql 'that'

      sut.corals.should.eql [42, true, 'that']

    it 'many calls', ->

      sut
      .given 4, 42, 420
      .given [42, true, 'that']
      .then().should.eql 'that'

      sut.corals.should.eql [4, 42, 420, 42, true, 'that']

  describe 'Helpers (dynamic given)', ->