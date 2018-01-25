require 'spec_helper'
require_relative 'corals/mastermind'

describe 'Mastermind' do

  def mastermind solution, _, *plays

    plays.each do |guess, feedback|
      test :mastermind,
        given: { solution: solution },
        when: { guess: guess },
        then: { feedback: feedback }
    end
  end

  it 'finds solution' do

    mastermind [:yellow, :yellow, :blue, :green],
      [          'guess'             , 'feedback'],
      [[:red, :red,   :brown, :brown], [        ]],
      [[:red, :green, :pink,  :brown], [ :white ]]

  end

end