require 'securerandom'

module Corals

  class Meta

    def initialize opts, rules
      @opts, @rules = opts, rules
    end

    def rules
      return anonymous_rules if anonymous_rules?
      return meta_rules if meta_rules?
      opts = @rules.nil? ? @opts :
        @opts.merge(rules: @rules)

      Corals.resolve(opts, meta_rules)[:rules]
    end

    def meta_rules?; @rules == meta_rules end
    def meta_rules; [:rules] end

    def anonymous_rules?; @rules and @rules[0].is_a?(Hash) end
    def anonymous_rules
      name = "rules_#{SecureRandom.hex}".to_sym
      define "#{name}" => { rules: @rules }
      [name]
    end
  end

end