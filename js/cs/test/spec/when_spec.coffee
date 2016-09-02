describe 'Events (when)', ->

  sut = {}
  beforeEach (done) ->
    sut = corals 42
    done()

  it 'returns then', ->
    sut.when().should.eql sut.then()

  it 'overrides defaults', ->
    sut.when().should.eql 42
    sut.when(420).should.eql 420

  it 'doesnt mutate state', ->
    sut.when(420).should.not.eql sut.then()
    sut.then().should.eql 42

  it 'precedes given memory', ->
    sut.given when: 'ping', then: 'pong'
    .when 'ping'
    .should.eql 'pong'

