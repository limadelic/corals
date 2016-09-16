_ = require 'lodash'

kind_of = (x) ->
  return 'array' if _.isArray x
  return 'fun' if _.isFunction x
  'value'

module.exports =

  array_of: (x) ->
    return x[0] if _.isArray(x) and x.length == 1 and _.isArray(x[0])
    return x if _.isArray x
    [x]

  bind_helpers: (to) ->
    helpers = ['given', 'when', 'then']
    methods = _.map helpers, (x) -> require("./#{x}").bind to
    _.zipObject helpers, methods

  do: (strategy, x, y) ->
    strategy[kind_of x]?[kind_of y]? x, y


