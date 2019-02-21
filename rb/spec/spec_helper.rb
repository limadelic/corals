require 'rr'
require 'rspec'
require 'hashie'
require 'pp'

RSpec.configure do |rspec|
  rspec.mock_framework = :rr
end

def stub_const class_with_constant, constant, value
  class_with_constant.__send__(:remove_const, constant)
  class_with_constant.const_set(constant, value)
end

def stub_methods sut=subject, methods
  methods.map { |x| stub(sut, x).returns x }
end

def stub_p
  stub($stdout).puts
  stub($stdout).p
end

def stub_rules rules
  rules.each { |x| stub(eval "Corals::Rules::#{x.to_s.camel_case}").rules {[]}}
end

def hashie(hash={}); Hashie::Mash.new hash end

require 'corals/global'

def test rule, test
  test = { given:{}, when: {}, then: {}}.merge test
  actual = resolve({rules: [rule]}.merge(test[:given]).merge(test[:when]))
  expect(Corals.when? actual, test[:then]).to be(true), "expected #{test[:then]} to match #{actual}"
end

class Corals::Context
  include RSpec::Matchers
end