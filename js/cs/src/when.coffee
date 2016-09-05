_ = require 'lodash'

module.exports = ->
  filter = @event.when
  return @result in filter if _.isArray filter
  return @result is filter.apply(@result).valueOf() if _.isFunction filter
  @result is filter