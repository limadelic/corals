require_relative 'context'

module Corals

  class Runner

    attr_reader :opts, :rules, :temp_facts

    def initialize opts, rules
      @opts, @rules = opts, rules
    end

    def is_compiling?; @is_compiling == true end
    def is_default? rule; (rule.keys & [:when, :when!]).empty? end

    def compile
      @is_compiling = true
      run
    ensure
      @is_compiling = false
    end

    def run
      with_new_context do
        rules.each do |rule|
          apply_rule rule, opts, opts[:user_options]
        end

        return results
      end
    end

    def with_new_context
      @opts = opts.clone
      @opts[:user_options] ||= {}
      @temp_facts = ['given', 'when', 'then', 'when!']
      yield
    end

    def given_first? rules
      rules.map do |x, _|
        return true if x == :given
        return false if x == :when
      end
    end

    def applicable? rule, scope
      return true if is_compiling? or is_default? rule
      return !is_shorted?(rule[:when!], scope) if on_short? rule
      matches? rule[:when], scope
    end

    def on_short? rule
      return @is_shorted = false unless rule.key? :when!
      true
    end

    def is_shorted? conditions, scope
      return true if @is_shorted
      @is_shorted = matches? conditions, scope
      false
    end

    def matches? conditions, scope
      conditions.kind_of?(Proc) ? Context.new(scope, self).expand(conditions) == true :
        conditions.all? do |setting, expected_value|
          current_value = scope[setting]

          (expected_value == current_value) || (!current_value.nil? && (
          (expected_value.kind_of?(Array) && expected_value.include?(current_value)) ||
            (expected_value.kind_of?(Proc) && Context.new(current_value, self).expand(expected_value, current_value) == true) ||
            (expected_value.kind_of?(Hash) && matches?(expected_value, current_value))
          ))
        end
    end

    def apply_rule rules, scope, user_scope = {}
      user_scope ||= {}
      return unless Hash === rules

      apply_given_rules rules[:given], scope, user_scope if given_first? rules
      return unless applicable? rules, scope
      apply_given_rules rules[:given], scope, user_scope unless given_first? rules

      rules.reject { |x| [:given, :when, :then].include? x }.each do |opt, value|
        apply_to_array(opt, value, scope, user_scope) or
          apply_recursive(opt, value, scope, user_scope) or
          apply_opt_rule(opt, value, scope, user_scope)
      end

      apply_opt_rule :then, rules[:then], scope, user_scope if rules.key? :then
    end

    def apply_given_rules rules_given, scope, user_scope
      return if is_compiling?
      return unless rules_given
      @temp_facts += rules_given.keys.map(&:to_s) if scope == opts
      apply_rule rules_given, scope, user_scope
    end

    def apply_to_array opt, rules, scope, user_scope
      return unless (scope[opt].is_a?(Array) or user_scope[opt].is_a?(Array)) and rules.is_a?(Hash)
      scope[opt].each { |x| apply_rule rules, x }
    end

    def apply_recursive opt, rules, scope, user_scope
      return unless rules.is_a? Hash
      scope[opt] ||= {}
      apply_rule rules, scope[opt], user_scope[opt]
    end

    def apply_opt_rule opt, value, scope, user_scope
      return if is_compiling? and value.is_a?(Proc)
      return if user_scope.key? opt
      opt = overridden opt
      inner_scope = (scope.is_a?(Hash) && scope.key?(opt)) ? scope[opt] : scope
      result = Context.new(inner_scope, self).expand value
      scope[opt] = result if scope.is_a? Hash
    end

    def overridden opt;
      opt.to_s.gsub(/!$/, '').to_sym
    end

    def results
      Hash[
        opts.reject { |k, _| temp_facts.include? "#{k}" }
          .map { |k, v| [k.to_sym, v] }
      ]
    end

  end

end