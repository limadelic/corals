{ _ } = require './helpers'

module.exports = ->
  _.given.call @
  return result.apply(@current).valueOf() if _.isFunction result
  result