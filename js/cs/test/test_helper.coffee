global.p = (x) -> console.log JSON.stringify x
global.m = (x) -> p (name for name of x)
global._ = require 'lodash'
global.corals = require '../src/corals'


