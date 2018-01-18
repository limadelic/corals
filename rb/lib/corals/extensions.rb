class String

  def same?(another)
    not another.nil? and
    self.downcase == another.downcase
  end

  def path_to_windows
    self.gsub '/', '\\'
  end

  def to_bool
    return true if self =~ (/^(true|t|yes|y|1)$/i)
    return false if self.empty? || self =~ (/^(false|f|no|n|0)$/i)

    raise ArgumentError.new "invalid value: #{self}"
  end

  def singular; self.gsub /s$/, '' end

  def split_sym; self.split.to_sym end

  def camel_case
    split('_').map(&:capitalize).join
  end

end

class Symbol

  def singular; self.to_s.singular.to_sym end

end

class Array

  def to_sym; self.map &:to_sym end

end

class NilClass

  def empty?; true end
  def to_sym; nil end
  def to_symd; nil end
  def [](x); nil end
  def b_to_tb; 0 end

end