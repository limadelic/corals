require 'spec_helper'
require_relative '../corals/dominoes'

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

    it 'empty table, each player with 10 dominoes' do

      test :dominoes,
        when: { on: :start },
        then: {
          table: [],
          players: -> { all? { |_, dominoes| expect(dominoes.count).to eq 10 }},
          dominoes: -> { expect(count).to eq 15 }
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
          on: :play,
          domino: [9,9],
          table: [],
          players: { player: [] }
        }

    end

    it 'finds a domino to play' do

      test :dominoes,
        given: {
          table: [[9,9]],
          players: { player: [[0,0],[9,8],[8,8]] }
        },
        when: { on: :turn, player: :player },
        then: {
          on: :play,
          domino: [9,8],
          table: [[9,9]],
          players: { player: [[0,0],[8,8]] }
        }

    end

    it 'knocks if cannot play' do

      test :dominoes,
        given: {
          table: [[9,9]],
          players: { player: [[0,0],[8,8]] }
        },
        when: { on: :turn, player: :player },
        then: {
          on: :knock,
          table: [[9,9]],
          players: { player: [[0,0],[8,8]] }
        }

    end

  end

  describe 'Play' do

    it 'the domino goes on the table' do

      test :dominoes,
        when: { on: :play, domino: [9,9] },
        then: { table: [[9,9]] }

    end

  end

end