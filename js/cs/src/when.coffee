_ = require 'lodash'

module.exports = ->
  return unless @coral?
  return true unless @coral.when?
  filter = @coral.when
  return @result in filter if _.isArray filter
  return @result is filter.apply(@result).valueOf() if _.isFunction filter
  @result is filter