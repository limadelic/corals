should = require 'should'

describe 'Given', ->
# It's got 2 uses static/dynamic
# static: builds up the chain of corals
# dynamic: used to keep temp/helper info

  sut = {}

  describe 'Static', ->
  # appends to corals
  # does not lead to a conclusion
  # just appends to the events

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

  describe 'Dynamic', ->
  # builds up temp info during then
  # it becomes part of this but not of result
  # use to extract methods/calculations
  # or setup before then
  # or as private
  # it obey's the when rules
  # precedes then

    beforeEach (done) ->
      sut = corals()
      done()

    it 'is not returned', ->

      should.not.exist sut.when given: 42

    it 'is and has it', ->

      sut.when given: 42
      (sut.is is sut.has is 42).should.be.true()

    it 'depends on when', ->

      sut.when given: 42, when: -> false
      should.not.exist sut.is

      sut.when given: 42, when: -> true
      sut.is.should.eql 42

    it 'is used in when', ->

      sut.when(
        { given: '53CR3T' }
        {  when: '53CR3T', then: kept: true }
        {  when: 'secret', then: kept: false }
      ).kept.should.be.true()



