module Corals

  class Context

    attr_reader :scope, :globals, :opts

    def initialize scope, globals
      @scope = scope
      @globals = globals
      @opts = globals.opts
    end

    def expand value, scope=@scope
      return value unless value.kind_of? Proc
      return if globals.is_compiling?
      return instance_exec &value if value.parameters.empty?
      instance_exec scope, &value
    end

    def has? key; (scope.is_a?(Hash) && scope.key?(key)) || opts.key?(key) end

    def method_missing(m, *args, &block)
      return super unless respond_to? m
      return scope[m] if scope.is_a?(Hash) && scope.key?(m)
      return scope.send m, *args, &block if scope.respond_to? m
      opts[m]
    end

    def respond_to?(method_sym, include_private = false)
      super || scope.respond_to?(method_sym, include_private) || has?(method_sym)
    end

  end

end