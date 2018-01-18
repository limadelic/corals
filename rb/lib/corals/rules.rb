require_relative 'extensions'

module Corals
  module Rules

    def self.define rules
      rules.each do |name, definition|
        add_module "#{name}".camel_case, definition
      end
    end

    def self.add_module name, definition
      new_module = Module.new
      new_module.define_singleton_method(:require) { definition[:require] || [] }
      new_module.define_singleton_method(:rules) { definition[:rules] || [] }
      const_set name, new_module
    end

    def self.find name
      const_get "#{name}".camel_case
    end

  end
end
