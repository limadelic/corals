require 'spec_helper'
require_relative 'corals/hello_world'

describe 'Hello World' do

  it 'says hello' do
    test :hello_world,
      given: { name: 'corals' },
      when: { say: 'Hello' },
      then: { said: 'Hello corals!' }
  end

end