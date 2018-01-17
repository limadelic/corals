require_relative 'resolver'
require_relative 'rules'

module Corals

  def self.given corals; Corals::Rules.define corals end

  def self.when? opts, predicate
    return unless predicate
    Resolver.new.resolve(opts, [{ when: predicate, then: true }])[:then]
  end

  def self.then opts, corals = nil
    Resolver.new.resolve opts, corals
  end

end

Corals.define corals: {}