_ = require 'lodash'

module.exports = (defaults, events...) ->
  new Corals defaults, array_of events

class Corals

  constructor: (@defaults, @events) ->

  given: (events...) =>
    @events = _.concat @events, array_of events
    @

  when: (events...) ->
    @then _.concat array_of(events), @events

  then: (events=@events) ->
    _.reduce events, reducer, @defaults

array_of = (x) ->
  return x[0] if _.isArray(x) and x.length == 1 and _.isArray(x[0])
  return x if _.isArray x
  [x]

reducer = (result, x) ->

  conditional = -> if x?.when? then x.then

  conditional() ? x



