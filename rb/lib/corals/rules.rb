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
        upsert_module "#{name}".camel_case, definition
      end
    end

    def self.upsert_module name, definition
      update_module(name, definition) or
      add_module(name, definition)
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

    def self.update_module name, definition
      return unless _module = find(name)

      ATTRS.each do |attr, default|
        current = _module.send(attr) || default
        values = definition.key?(attr) ? definition[attr] : default

        raise "Expected #{attr} in #{name} to be a #{current.class}" unless current.class == values.class

        _module.define_singleton_method attr do
          Hash === current ?
            current.merge(values) :
            current + values
        end
      end
    end

    def self.find name
      const_get "#{name}".camel_case
    rescue
      false
    end

  end
end
