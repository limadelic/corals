_ = require 'lodash'

module.exports = (corals=[]) ->
  corals = array_of corals

  given: (more=[]) ->
    corals = _.concat corals, array_of more
    @

  when: (events=[]) -> @then _.concat array_of(events), corals

  then: (all=corals) -> _.reduce all, reducer

array_of = (x) -> _.isArray(x) and x or [x]

reducer = (result, x) ->

  conditional = -> if x.when? then x.then

  conditional() ? x



