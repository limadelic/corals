_ = require 'lodash'

module.exports = ->
  return @coral unless _.isObject @coral
  @do.given()
  return @result unless @coral.then?
  return @coral.then.apply(@result).valueOf() if _.isFunction @coral.then
  @coral['then']