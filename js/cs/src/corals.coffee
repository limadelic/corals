_ = require 'lodash'
{ array_of, bind_helpers } = require './helpers'

module.exports = (core, corals...) ->
  new Corals core, array_of corals

class Corals

  constructor: (@core, @corals) ->
    @do = bind_helpers @

  given: (corals...) ->
    @corals = _.concat @corals, array_of corals
    @

  when: (corals...) ->
    @then _.concat array_of(corals), @corals

  then: (corals=@corals) ->
    _.reduce corals, @reduce, @core

  reduce: (@result, @coral) =>
    if @do.when() then @do.then() else @result