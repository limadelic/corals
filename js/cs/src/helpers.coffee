_ = require 'lodash'
_.when = require './when'
_.then = require './then'

module.exports =

  reducer: (context, event) ->
    return context unless event?
    return event unless event.when?
    _.when(event, context) and _.then(event, context) or context

  array_of: (x) ->
    return x[0] if _.isArray(x) and x.length == 1 and _.isArray(x[0])
    return x if _.isArray x
    [x]
