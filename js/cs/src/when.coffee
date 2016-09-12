_ = require 'lodash'

_.when = (filter) ->
  return @result in filter if _.isArray filter
  return @result is filter.apply(@result).valueOf() if _.isFunction filter
  @result is filter

module.exports = ->
  return unless @coral?
  return true unless @coral.when?
  _.when.call @, @coral.when

