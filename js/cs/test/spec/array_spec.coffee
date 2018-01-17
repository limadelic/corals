describe 'Arrays', ->

  sut = [4, 42, [4, 20]]

  it 'core', ->
    corals(sut).then().should.eql sut

  describe 'Given', ->

    it.skip 'value', ->
      corals sut,
        { given: true }
        { when: true, then: true }
      .then().should.eql [true, true, true]

  describe 'When', ->

    describe 'Whole', ->

      it 'value', ->

        corals(sut).when
          when: 42
          then: true
        .should.eql sut

      it 'array', ->

        corals(sut).when
          when: [4, 42, [4, 20]]
          then: true
        .should.be.true()

      it 'fun', ->

        corals(sut).when
          when: -> [4, 42, [4, 20]]
          then: true
        .should.be.true()

      it 'this', ->

        corals(sut).when
          when: -> _.includes @, 42
          then: true
        .should.be.true()

    describe 'Item', ->

      it 'value', ->

        corals(sut).when
          when: 42
          then: true
        .should.eql [4, true, [4, 20]]

      it 'array', ->

        corals(sut).when
          when: [4, 20]
          then: true
        .should.eql [4, 42, true]

      it 'fun', ->

        corals(sut).when
          when: -> 4
          then: true
        .should.eql [true, 42, [4, 20]]

      it 'this', ->

        corals(sut).when
          when: -> _.isNumber @
          then: true
        .should.eql [true, true, [4, 20]]

  describe 'Then', ->

    it 'value', ->
      corals sut
      .when then: true
      .should.eql [true, true, true]

    it 'array', ->
      corals sut
      .when then: [true]
      .should.eql [true]
