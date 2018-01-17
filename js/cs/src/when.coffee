_ = require 'lodash'
_.do = require('./helpers').do

module.exports = (result, coral) ->
  return unless coral
  return true unless coral.when
  _.do(whens, result, coral.when) or
    _.do(whens, @is, coral.when)

whens = (result, valid) ->
  value:
    value: -> result is valid
    array: -> result in valid
    fun: ->
      valid = valid.apply(result).valueOf()
      result is valid or (result isnt false and valid is true)
  array:
    value: -> valid in result
    array: -> _.isEqual result, valid
    fun: ->
      valid = valid.apply(result).valueOf()
      result is valid or (result isnt false and valid is true)
  fun:
    value: ->
