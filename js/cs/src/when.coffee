_ = require 'lodash'

module.exports = (condition, current) ->
  return current in condition if _.isArray condition
  return current is condition.apply(current).valueOf() if _.isFunction condition
  current is condition