require 'spec_helper'
require 'corals/dominoes'

describe 'Dominoes' do

  describe 'Game' do

    it '1 table 4 players & 55 dominoes' do

      test :dominoes, then: {
        table: [],
        players: -> { expect(count).to eq 4 },
        dominoes: -> { expect(count).to eq 55 }
      }

    end

  end

  describe 'Start' do

    xit 'empty table, each player with 10 dominoes' do

      test :dominoes,
        when: { on: :start },
        then: {
          table: [],
          players: -> { all? { |_, dominoes| expect(dominoes.count).to eq 10 }},
          # dominoes: -> { expect(count).to eq 15 }
        }

    end

  end

  describe 'Turn' do

    xit 'can play anything if table is empty' do

      test :dominoes,
        given: {
          table:[],
          players: {
            player: [[9,9]]
          }
        },
        when: { on: :turn, player: :player },
        then: {
          table: [[9,9]],
          players: {
            player: []
          }
        }
    end

  end

end