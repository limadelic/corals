require_relative 'loader'
require_relative 'parser'
require_relative 'runner'
require_relative 'meta'
require_relative 'anonymous'

module Corals

  class Resolver

    include Anonymous

    attr_reader :loader, :parser, :runner, :meta
    attr_accessor :opts, :rules, :defaults

    def initialize opts={}, rules=nil, defaults={}
      @opts, @rules, @defaults = opts, rules, defaults
      @loader = Loader.new
      @parser = Parser.new
      @runner = Loader.new
      @meta = Meta.new self
    end

    def resolve; load; parse; run end

    def load
      @rules = loader.load meta.rules
    end

    def parse

    end

    def run
      runner.run rules, opts
    end

  end

end