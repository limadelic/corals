module.exports = (x) ->
  given: (y) ->
    x = y
    @
  then: -> x
