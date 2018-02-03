require 'spec_helper'
require 'corals/dominoes'

describe 'Dominoes' do

  describe 'Game' do

    it '1 table 4 players & 55 dominoes' do

      test :dominoes, then: {
        table: [],
        players: -> { expect(count).to be 4 },
        dominoes: -> { expect(count).to be 55 }
      }

    end

  end

  describe 'Start' do

    it 'empty table, each player with 10 dominoes' do

      test :dominoes,
        when: { on: :start },
        then: {
          table: [],
          players: -> { each { |_, dominoes| expect(dominoes.count).to be 10 }},
          dominoes: -> { expect(count).to be 15 }
        }

    end

  end

  describe 'Turn' do

    it 'can play anything if table is empty' do

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