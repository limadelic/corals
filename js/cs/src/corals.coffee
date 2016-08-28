_ = require 'lodash'

module.exports = (defaults, events=[]) ->
  new Corals defaults, events

class Corals

  constructor: (@defaults, @events) ->

  given: (events=[]) =>
    @events = _.concat @events, array_of events
    @

  when: (events=[]) ->
    @then _.concat array_of(events), @events

  then: (events=@events) ->
    _.reduce events, reducer, @defaults

array_of = (x) -> _.isArray(x) and x or [x]

reducer = (result, x) ->

  conditional = -> if x?.when? then x.then

  conditional() ? x



