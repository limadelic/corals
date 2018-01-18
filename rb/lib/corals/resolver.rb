require_relative 'loader'
require_relative 'parser'
require_relative 'context'

module Corals

  class Resolver

    attr_reader :opts, :user_options, :temp_facts
    attr_reader :loader

    def initialize
      @loader = Loader.new
    end

    def resolve user_options = {}, rules = nil
      rules = loader.load applicable rules, user_options unless anonymous? rules
      parse user_options, rules
      run rules, user_options
    end

    def applicable rules, user_options
      return rules if anonymous? rules
      return [:rules] if rules == [:rules]
      opts = rules.nil? ? user_options :
        user_options.merge(rules: rules)
      resolve(opts, [:rules])[:rules]
    end

    def anonymous? rules;
      rules and rules[0].kind_of?(Hash)
    end

    def parse user_options, rules
      return if user_options.empty?
      Parser.parse user_options, compile(rules)
    end

    def run rules, user_options = {}
      with_new_context user_options do
        rules.each { |rule| apply_rule rule, opts, user_options }
        return results
      end
    end

    def is_compiling?;
      @is_compiling == true
    end

    def compile rules
      @is_compiling = true
      run rules
    ensure
      @is_compiling = false
    end

    def with_new_context user_options
      @user_options = user_options.clone
      @opts = user_options.clone
      @temp_facts = ['given', 'when', 'when!']
      yield
    end

    def applicable? rule, scope
      is_compiling? || is_default?(rule) || matches?(rule[:when], scope)
    end

    def applicable! rule, scope
      is_compiling? || !rule.key?(:when!) || matches?(rule[:when!], scope)
    end

    def is_default? rule
      rule[:when].nil?
    end

    def matches? conditions, scope
      conditions.kind_of?(Proc) ? Context.new(scope, self).expand(conditions) == true :
        conditions.all? do |setting, expected_value|
          current_value = scope[setting]

          (expected_value == current_value) || (!current_value.nil? && (
          (expected_value.kind_of?(Array) && expected_value.include?(current_value)) ||
            (expected_value.kind_of?(Proc) && Context.new(scope, self).expand(expected_value) == true) ||
            (expected_value.kind_of?(Hash) && matches?(expected_value, current_value))
          ))
        end
    end

    def apply_rule rules, scope, user_scope = {}
      user_scope ||= {}
      return unless rules && applicable!(rules, scope)

      apply_given_rules rules[:given], scope, user_scope
      return unless applicable? rules, scope

      rules.reject { |x| [:given, :when].include? x }.each do |opt, value|
        apply_to_array(value, scope[opt]) or
          apply_recursive(opt, value, scope, user_scope) or
          apply_opt_rule(opt, value, scope, user_scope)
      end
    end

    def apply_given_rules rules_given, scope, user_scope
      return if is_compiling?
      return unless rules_given
      @temp_facts += rules_given.keys.map(&:to_s) if scope == opts
      apply_rule rules_given, scope, user_scope
    end

    def apply_to_array rules, scope
      return unless scope.kind_of?(Array) and rules.kind_of?(Hash)
      scope.each { |x| apply_rule rules, x }
    end

    def apply_recursive opt, rules, scope, user_scope
      return unless rules.kind_of? Hash
      scope[opt] ||= {}
      apply_rule rules, scope[opt], user_scope[opt]
    end

    def apply_opt_rule opt, value, scope, user_scope
      return if is_compiling? and value.kind_of?(Proc)
      return if user_scope.key? opt
      scope[overridden opt] = Context.new(scope, self).expand value
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