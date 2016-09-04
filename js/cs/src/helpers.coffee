_ = require 'lodash'
_.when = require './when'
_.then = require './then'

module.exports =

  reducer: (current, next) ->
    return current unless next?
    return _.then next, current unless next.when?
    return _.then next, current if _.when next.when, current
    current

  array_of: (x) ->
    return x[0] if _.isArray(x) and x.length == 1 and _.isArray(x[0])
    return x if _.isArray x
    [x]
