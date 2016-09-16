_ = require 'lodash'
_.do = require('./helpers').do

module.exports = ->
  return unless @coral?
  return true unless @coral.when?
  _.do(whens, @result, @coral.when) or
    _.do(whens, @is, @coral.when)

whens =
  value:
    value: (x, y) -> x is y
    array: (x, y) -> x in y
    fun: (x, y) ->
      y = y.apply(x).valueOf()
      x is y or (x isnt false and y is true)

