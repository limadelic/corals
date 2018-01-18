require_relative 'corals'

def define rules; Corals.define rules end

def resolve opts, rules = nil; Corals.resolve opts, rules end
