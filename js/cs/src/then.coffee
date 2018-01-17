_ = require 'lodash'
_.do = require('./helpers').do

module.exports = (result, coral) ->
  return coral unless _.isObject coral
  @do.given coral
  return result unless coral.then?
  _.do(thens, result, coral.then, coral) or coral.then

thens = (current, next)->
  value:
    fun: -> next.apply(current).valueOf()
  array:
    value: (coral) -> _.map current, (x) => @reduce x, coral
    fun: -> next.apply(current).valueOf()
