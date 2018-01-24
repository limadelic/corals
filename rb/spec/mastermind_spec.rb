require 'spec_helper'
require_relative 'corals/mastermind'

describe 'Mastermind' do

  let(:solution) {{ solution: [:yellow, :yellow, :blue, :green] }}

  it 'finds no match' do
    test :mastermind,
      given: solution,
      when: { guess: [:red, :red, :brown, :brown] },
      then: { feedback: [] }
  end

  xit 'matches one out of order' do
    test :mastermind,
      given: solution,
      when: { guess: [:red, :green, :pink, :brown] },
      then: { feedback: [:white] }
  end

end