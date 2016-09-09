_ = require 'lodash'

module.exports =

  array_of: (x) ->
    return x[0] if _.isArray(x) and x.length == 1 and _.isArray(x[0])
    return x if _.isArray x
    [x]

  bind_helpers: (to) ->
    helpers = ['given', 'when', 'then']
    methods = _.map helpers, (x) -> require("./#{x}").bind to
    _.zipObject helpers, methods

