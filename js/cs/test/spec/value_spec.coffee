describe 'Values (numbers, bools, strings ...)', ->

  values = [0, true, '42']

  it 'default', ->
    values.forEach (x) ->
      corals(x).then().should.eql x

  describe 'Given', ->

    it 'value'

    it 'hash'

  describe 'Whens', ->

    it 'value'
#      corals 0, [
#        {when: 42, }
#      ]

    it 'array'
    it 'lambda'
    it 'self'

  describe 'Then', ->

    it 'value'
    it 'lambda'
    it 'self'
