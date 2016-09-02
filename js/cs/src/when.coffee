_ = require 'lodash'

module.exports = (event, context) ->
  _.isArray(event.when) and context in event.when or
  event.when is context