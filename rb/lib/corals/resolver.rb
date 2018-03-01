require_relative 'loader'
require_relative 'parser'
require_relative 'runner'
require_relative 'meta'

module Corals

  class Resolver

    attr_reader :opts, :rules

    def initialize opts={}, rules=nil
      @opts, @rules = opts, rules
    end

    def loader; Loader.new end
    def meta; Meta.new opts, rules end
    def parser; Parser.new end
    def runner; Runner.new opts, rules end

    def resolve; load; parse; run end

    def load; @rules = loader.load meta.rules end

    def parse; parser.parse opts, runner.compile unless opts.empty? end

    def run; runner.run end

  end

end