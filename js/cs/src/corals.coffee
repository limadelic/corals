_ = require 'lodash'
{ reducer, array_of } = require './helpers'

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



