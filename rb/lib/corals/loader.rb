require_relative 'rules'

module Corals
  class Loader

    def load rules
      rules ||= []

      [required(rules) + rules]
        .flatten.uniq
        .map { |x| module_of(x).rules }.flatten
    end

    def required rules
      rules
        .map { |x| [x, module_of(x)] }
        .map { |x, m| required(m.require) + [x] }
    end

    def module_of rules
      Rules.find rules
    end

  end
end