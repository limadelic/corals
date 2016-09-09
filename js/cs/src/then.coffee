_ = require 'lodash'

module.exports = ->
  result = @event.then ? @event
  return result.apply(@result).valueOf() if _.isFunction result
  result