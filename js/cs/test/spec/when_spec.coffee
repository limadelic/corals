describe 'Events (when)', ->

  sut = corals 42

  it 'then', ->
    sut.when().should.eql sut.then()

  it 'default', ->
    sut.when().should.eql 42
    sut.when(420).should.eql 420

  it 'stateless', ->
    sut.when(420).should.not.eql sut.then()
    sut.then().should.eql 42

  it 'single', ->
    sut.given when: 'ping', then: 'pong'
    .when 'ping'
    .should.eql 'pong'

  it 'many', ->
    sut.given when: 'ping', then: 'pong'
    .when [
      { when: 42, then: 'pong' }
      { when: 'pong', then: 'ping' }
    ]
    .should.eql 'pong'

