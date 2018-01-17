require_relative 'rules'

module Corals
  class Loader

    def load corals
      corals ||= []

      [required(corals) + corals]
        .flatten.uniq
        .map { |x| module_of(x).corals }.flatten
    end

    def required corals
      corals
        .map { |x| [x, module_of(x)] }
        .map { |x, m| required(m.require) + [x] }
    end

    def module_of corals
      Given.find corals
    end

  end
end