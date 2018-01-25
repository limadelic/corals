module Corals
  class Parser

    def self.parse hash, types
      return unless hash.is_a? Hash
      hash.keys
        .map { |key| [key, types[key]] }
        .reject { |_, type| type.nil? }
        .each do |key, type|

        parse_hash(hash, key, type) or
          parse_boolean(hash, key, type) or
          parse_symbol(hash, key, type) or
          parse_number(hash, key, type)

      end
    end

    def self.parse_hash hash, key, type
      return unless type.is_a? Hash
      parse hash[key], type
    end

    def self.parse_boolean hash, key, type
      return unless [true, false].include? type
      hash[key] = /^#{type}$/i === "#{hash[key]}" ? type : !type
    end

    def self.parse_symbol hash, key, type
      return unless type.is_a? Symbol
      hash[key] = hash[key].to_sym
    end

    def self.parse_number hash, key, type
      return unless type.is_a? Fixnum
      hash[key] = hash[key].to_i
    end

  end
end