require 'rr'
require 'rspec'
require 'hashie'
require 'pp'

RSpec.configure do |rspec|
  rspec.mock_framework = :rr
end

def spy(value)
  p value
  value
end

def stub_const class_with_constant, constant, value
  class_with_constant.__send__(:remove_const, constant)
  class_with_constant.const_set(constant, value)
end

def stub_p
  stub($stdout).puts
  stub($stdout).p
end

def hashie(hash={}); Hashie::Mash.new hash end
