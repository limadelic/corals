_ = require 'lodash'

module.exports = (result, current) ->
  return result.apply(current).valueOf() if _.isFunction result
  result