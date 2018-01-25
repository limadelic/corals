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

  it 'learn the rules' do

    mastermind [:yellow, :yellow, :blue, :green],
      [          'guess'             , 'feedback'],
      [[:red,   :red, :brown,  :brown ], [        ]],
      [[:green, :red, :purple, :purple], [ :white ]],
      [[:red,   :red, :purple, :yellow], [ :white ]]

  end

  it 'matches wiki' do

    mastermind [:green, :blue, :red, :purple],
      [              'guess'               ,            'feedback'             ],
      [[:yellow, :yellow, :blue,   :blue  ], [ :white                         ]]
      [[:purple, :red,    :red,    :yellow], [ :black, :white                 ]]
      [[:blue,   :purple, :blue,   :yellow], [ :black, :white                 ]]
      [[:red,    :red,    :purple, :yellow], [ :white                         ]]
      [[:blue,   :red,    :green,  :purple], [ :black, :white, :white, :white ]]
      [[:green,  :blue,   :red,    :purple], [ :black, :black, :black, :black ]]

  end

end