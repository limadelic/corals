require_relative 'rules'

module Corals

  class Loader

    SPACER = { when: -> { true }}

    def load rules
      rules ||= []

      required(rules)
        .uniq
        .map { |x| module_of(x).rules + [SPACER] }
        .flatten.compact
    end

    def required rules
      rules
        .map { |x| [x, module_of(x)] }
        .map { |x, m| required(m.require) + [x] }
        .flatten
    end

    def module_of rules; Rules.find rules end

  end
end