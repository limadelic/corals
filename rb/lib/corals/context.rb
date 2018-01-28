module Corals

  class Context

    attr_reader :scope, :globals, :opts, :user_options

    def initialize scope, globals
      @scope = scope
      @globals = globals
      @opts = globals.opts
      @user_options = globals.user_options
    end

    def expand value, scope
      return value unless value.kind_of? Proc
      return if globals.is_compiling?
      return instance_exec &value if value.parameters.empty?
      instance_exec scope, &value
    end

    def has? key; (scope.is_a?(Hash) && scope.key?(key)) || opts.key?(key) end

    def method_missing(m, *args, &block)
      return (scope.is_a?(Hash) && scope[m]) || opts[m] if respond_to? m
      super
    end

    def respond_to?(method_sym, include_private = false)
      super || has?(method_sym)
    end

  end

end