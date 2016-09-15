_ = require 'lodash'

_.when = (filter) ->
  return @result in filter if _.isArray filter
  return when_fun filter, @result if _.isFunction filter
  filter in [@is, @result]

when_fun = (filter, result) ->
  returned = filter.apply(result).valueOf()

  result is returned or (
    result isnt false and returned is true
  )

module.exports = ->
  return unless @coral?
  return true unless @coral.when?
  _.when.call @, @coral.when

