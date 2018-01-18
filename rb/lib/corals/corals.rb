require_relative 'resolver'
require_relative 'rules'

module Corals

  def self.define rules; Rules.define rules end

  def self.when? opts, predicate
    return unless predicate
    Resolver.new.resolve(opts, [{ when: predicate, then: true }])[:then]
  end

  def self.resolve opts, corals = nil
    Resolver.new.resolve opts, corals
  end

end

Corals.define rules: {}