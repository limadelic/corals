require_relative 'extensions'

module Corals
  module Rules

    ATTRS = {
      require: [],
      defaults: {},
      rules: []
    }

    def self.define rules
      rules.each do |name, definition|
        add_module "#{name}".camel_case, definition
      end
    end

    def self.add_module name, definition
      new_module = Module.new

      ATTRS.each do |attr, default|
        new_module.define_singleton_method attr do
          definition.key?(attr) ? definition[attr] : default
        end
      end

      const_set name, new_module
    end

    def self.find name
      const_get "#{name}".camel_case
    end

  end
end
