require 'securerandom'

require_relative 'resolver'
require_relative 'parser'
require_relative 'runner'

module Corals

  class Meta

    attr_reader :scope

    def initialize scope
      @scope = scope
    end

    def rules
      return anonymous if anonymous?
      return [:rules] if rules == [:rules]
      opts = rules.nil? ? opts :
        opts.merge(rules: rules)

      Corals.resolve(opts, [:rules])[:rules]
    end

    def anonymous
      define "rules_#{SecureRandom.hex}".to_sym,
        defaults: scope.defaults,
        rules: scope.rules
    end

    def anonymous? rules; rules and rules[0].is_a?(Hash) end


  end

end