require 'hashie'

require_relative 'loader'
require_relative 'parser'
require_relative 'runner'

module Corals

  class Resolver

    attr_reader :loader, :runner

    def initialize
      @loader = Loader.new
      @runner = Runner.new
    end

    def resolve opts={}, rules=nil, defaults={}
      rules = load opts, rules, defaults
      parse opts, rules
      runner.run rules, opts
    end

    def load opts={}, rules=nil, defaults={}
      anonymous(rules, defaults) or
      loader.load(applicable(rules, opts))
    end

    def anonymous rules, defaults
      Hashie::Mash.new rules: rules, defaults: defaults if anonymous? rules
    end

    def applicable rules, opts
      return rules if anonymous? rules
      return [:rules] if rules == [:rules]
      opts = rules.nil? ? opts :
        opts.merge(rules: rules)

      resolve(opts, [:rules])[:rules]
    end

    def anonymous? rules;
      rules and rules[0].is_a?(Hash)
    end

    def parse opts, rules
      return if opts.empty?
      Parser.parse opts, runner.compile(rules)
    end

  end

end