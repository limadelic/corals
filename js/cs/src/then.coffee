_ = require 'lodash'

module.exports = ->
  result = @coral.then ? @coral
  return result.apply(@result).valueOf() if _.isFunction result
  result