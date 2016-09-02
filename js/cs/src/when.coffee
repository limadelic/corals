_ = require 'lodash'

module.exports = (condition, current) ->
  _.isArray(condition) and current in condition or
  _.isFunction(condition) and current is condition() or
  current is condition