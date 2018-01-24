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

    def resolve user_options = {}, rules = nil
      rules = loader.load applicable rules, user_options unless anonymous? rules
      parse user_options, rules
      runner.run rules, user_options
    end

    def applicable rules, user_options
      return rules if anonymous? rules
      return [:rules] if rules == [:rules]
      opts = rules.nil? ? user_options :
        user_options.merge(rules: rules)
      resolve(opts, [:rules])[:rules]
    end

    def anonymous? rules;
      rules and rules[0].kind_of?(Hash)
    end

    def parse user_options, rules
      return if user_options.empty?
      Parser.parse user_options, runner.compile(rules)
    end

  end

end