_ = require 'lodash'

module.exports = (corals=[]) ->
  corals = array_of corals

  given: (new_corals=[]) ->
    corals = _.merge corals, array_of new_corals
    @

  then: -> _.last corals

array_of = (x) -> _.isArray(x) and x or [x]

