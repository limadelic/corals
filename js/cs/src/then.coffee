_ = require 'lodash'
_.given = require './given'

module.exports = (result, current) ->
  _.given result, current
  return result.apply(current).valueOf() if _.isFunction result
  result