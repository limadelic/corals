module Corals

  module Anonymous

    def anonymous rules, defaults
      return unless anonymous? rules
      Hashie::Mash.new rules: rules, defaults: defaults
    end

    def anonymous? rules; rules and rules[0].is_a?(Hash) end

  end

end