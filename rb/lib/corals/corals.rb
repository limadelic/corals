require_relative 'resolver'
require_relative 'rules'

module Corals

  def self.define rules; Rules.define rules end

  def self.when? opts, predicate
    return unless predicate
    Resolver.new(opts, [{ when: predicate, return: true }]).resolve[:return]
  end

  def self.resolve opts={}, corals = nil, defaults={}
    Resolver.new(opts, corals, defaults).resolve
  end

end

Corals.define rules: {}