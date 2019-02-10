require 'spec_helper'
require_relative '../corals/dominoes'

describe 'Dominoes' do

  describe 'Defaults' do

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
        given: { players: { player: [[9,9]] } },
        when: { on: :turn },
        then: { domino: [9,9], players: { player: [] }}

    end

    it 'finds a domino to play' do

      test :dominoes,
        given: { table: [[9,9]], players: { player: [[0,0],[9,8],[8,8]] }},
        when: { on: :turn },
        then: { domino: [9,8], players: { player: [[0,0],[8,8]] }}

    end

    it 'finds nothing if cannot play' do

      test :dominoes,
        given: { table: [[9,9]], players: { player: [[0,0],[8,8]] }},
        when: { on: :turn },
        then: { domino: nil, players: { player: [[0,0],[8,8]] }}

    end

  end

  describe 'Play' do

    it 'the domino goes on the table' do

      test :dominoes,
        when: { on: :play, domino: [9,9] },
        then: { table: [[9,9]] }

    end

    it 'the head indicates preference' do

      test :dominoes,
        given: { table: [[9,9],[9,8],[8,7]] },
        when: { on: :play, domino: [9,7] },
        then: { table: [[7,9],[9,9],[9,8],[8,7]] }

      test :dominoes,
        given: { table: [[9,9],[9,8],[8,7]] },
        when: { on: :play, domino: [7,9] },
        then: { table: [[9,9],[9,8],[8,7],[7,9]] }

    end

    it 'the tail is an afterthought' do

      test :dominoes,
        given: { table: [[9,9]] },
        when: { on: :play, domino: [7,9] },
        then: { table: [[7,9],[9,9]] }

      test :dominoes,
        given: { table: [[9,9],[9,8]] },
        when: { on: :play, domino: [7,8] },
        then: { table: [[9,9],[9,8],[8,7]] }

    end

  end

  describe 'Done' do

    it 'counts the dominoes' do

      test :dominoes,
        given: {
          players: {
            player: [[0,0]],
            right: [[1,1]],
            front: [[2,2]],
            left: [[3,3]],
          }
        },
        when: { on: :done },
        then: {
          players: {
            player: 0,
            right: 2,
            front: 4,
            left: 6,
          }
        }

    end

    it 'picks a winner'

  end

  describe 'Controller' do

    it 'starts the game' do

      test :dominoes, then: { on: :start }

    end

    it 'player has the first turn' do

      test :dominoes,
        when: { on: :start },
        then: { on: :turn, player: :player }

    end

    it 'plays the domino' do

      test :dominoes,
        given: { players: { player:[:domino] } },
        when: { on: :turn, player: :player },
        then: { on: :play }

    end

    it 'knocks' do

      test :dominoes,
        when: { on: :turn, player: :player },
        then: { on: :knock, knocked: [:player] }

    end

    it 'finds next player after play' do

      test :dominoes,
        given: { players: { player: [:more_dominoes]}},
        when: { on: :play, domino: :domino },
        then: { on: :turn, player: :right }

    end

    it 'finds next player after knock' do

      test :dominoes,
        when: { on: :knock, player: :left },
        then: { on: :turn, player: :player }

    end

    it 'stops the game when stuck' do

      test :dominoes,
        given: { knocked: [:right, :front, :left, :player]},
        when: { on: :knock },
        then: { on: :stuck }

    end

    it 'calls the winner' do

      test :dominoes,
        when: { on: :play, domino: :domino },
        then: { on: :won }

    end

  end

  describe 'Game' do

    let(:game) {{}}

    def play game
      game = resolve game, [:dominoes] until game[:winner]
      game
    end

    xit 'stuck, player wins' do
      game = play(
        on: :turn,
        table: [[9,9]],
        players: {
          player: [[0,0]],
          right: [[1,1]],
          front: [[2,2]],
          left: [[3,3]],
        }
      )

      expect(game[:winner]).to be :player
    end

    it 'stuck, all tie'
    it 'player wins'
    it 'play a game'

  end

end