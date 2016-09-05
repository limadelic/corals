_ = require 'lodash'
{ array_of, bind_helpers } = require './helpers'

module.exports = (defaults, events...) ->
  new Corals defaults, array_of events

class Corals

  constructor: (@defaults, @events) ->
    @do = bind_helpers.call @

  given: (events...) =>
    @events = _.concat @events, array_of events
    @

  when: (events...) ->
    @then _.concat array_of(events), @events

  then: (events=@events) ->
    _.reduce events, @reducer, @defaults

  reducer: (@result, @event) =>
    @do.given()
    if @on_event() then @do.then() else @result

  on_event: -> @event? and not @event.when? or @do.when()




