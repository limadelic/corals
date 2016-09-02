_ = require 'lodash'

module.exports = (result) ->
  return result() if _.isFunction result
  result