require 'spec_helper'
require_relative '../corals/dominoes'

describe 'Dominoes' do

  describe 'Defaults' do

    it 'has 4 players and a table' do

      test :dominoes,
        then: {
          table: [],
          players: -> { expect(count).to be 4 }
        }

    end

  end

  describe 'Start' do

    it 'empty table, each player with 10 dominoes' do

      test :dominoes,
        when: { on: :start },
        then: {
          table: [],
          players: -> { all? { |player| expect(player[:dominoes].count).to eq 10 } },
        }

    end

  end

  describe 'Turn' do

    it 'can play anything if table is empty' do

      test :dominoes,
        given: { table: [] },
        when: { on: :turn, player: { dominoes: [[9, 9]] } },
        then: { domino: [9, 9], player: { dominoes: [] } }

    end

    it 'finds a domino to play' do

      test :dominoes,
        given: { table: [[9, 9]] },
        when: { on: :turn, player: { dominoes: [[0, 0], [9, 8], [8, 8]] } },
        then: { domino: [9, 8], player: { dominoes: [[0, 0], [8, 8]] } }

    end

    it 'finds nothing if cannot play' do

      test :dominoes,
        given: { table: [[9, 9]] },
        when: { on: :turn, player: { dominoes: [[0, 0], [8, 8]] } },
        then: { domino: nil, player: { dominoes: [[0, 0], [8, 8]] } }

    end

  end

  describe 'Play' do

    before do
      stub_rules [:controller]
    end

    it 'the domino goes on the table' do

      test :dominoes,
        given: { table: [] },
        when: { on: :play, domino: [9, 9] },
        then: { table: [[9, 9]] }

    end

    it 'the head indicates preference' do

      test :dominoes,
        given: { table: [[9, 9], [9, 8], [8, 7]] },
        when: { on: :play, domino: [9, 7] },
        then: { table: [[7, 9], [9, 9], [9, 8], [8, 7]] }

      test :dominoes,
        given: { table: [[9, 9], [9, 8], [8, 7]] },
        when: { on: :play, domino: [7, 9] },
        then: { table: [[9, 9], [9, 8], [8, 7], [7, 9]] }

    end

    it 'the tail is an afterthought' do

      test :dominoes,
        given: { table: [[9, 9]] },
        when: { on: :play, domino: [7, 9] },
        then: { table: [[7, 9], [9, 9]] }

      test :dominoes,
        given: { table: [[9, 9], [9, 8]] },
        when: { on: :play, domino: [7, 8] },
        then: { table: [[9, 9], [9, 8], [8, 7]] }

    end

  end

  describe 'Done' do

    let(:players) { [
      { name: :right, dominoes: [[1, 1]] },
      { name: :player, dominoes: [[0, 0]] },
      { name: :front, dominoes: [[2, 2]] },
      { name: :left, dominoes: [[3, 4]] },
    ] }

    it 'counts the dominoes' do

      test :dominoes,
        given: { players: players },
        when: { on: :done },
        then: { players: -> { zip([0, 2, 4, 7]).all? { |player, score|
          expect(player[:score]).to be score
        } } }

    end

    it 'picks a winner' do

      test :dominoes,
        given: { players: players },
        when: { on: :done },
        then: { winner: { name: :player } }

    end

  end

  describe 'Controller' do

    before do
      stub_rules [:start, :turn, :play]
    end

    it 'starts the game' do

      test :dominoes, then: { on: :start }

    end

    it 'player has the first turn' do

      test :dominoes,
        when: { on: :start },
        then: { on: :turn, player: { name: :player }}

    end

    it 'plays the domino' do

      test :dominoes,
        when: { on: :turn, domino: [9,9] },
        then: { on: :play }

    end

    it 'knocks' do

      test :dominoes,
        when: { on: :turn },
        then: { on: :knock }

    end

    it 'finds next player after play' do

      test :dominoes,
        when: { on: :play, domino: :domino, player: { name: :player }},
        then: { on: :turn, player: { name: :right }}

    end

    it 'finds next player after knock' do

      test :dominoes,
        when: { on: :knock, player: { name: :left }},
        then: { on: :turn, player: { name: :player }}

    end

    it 'stops the game when stuck' do

      test :dominoes,
        given: { players: 4.times.map {{knocked: true}}},
        when: { on: :knock },
        then: { on: :stuck }

    end

    it 'calls the winner' do

      test :dominoes,
        when: { on: :play, domino: :domino, player: { dominoes: []}},
        then: { on: :won }

    end

  end

  describe 'Game' do

    let(:game) { {} }

    def play game
      game = resolve game, [:dominoes] until game[:winner]
      game
    end

    xit 'stuck, player wins' do
      game = play(
        on: :turn,
        table: [[9, 9]],
        players: {
          player: [[0, 0]],
          right: [[1, 1]],
          front: [[2, 2]],
          left: [[3, 3]],
        }
      )

      expect(game[:winner]).to be :player
    end

    it 'stuck, all tie'
    it 'player wins'
    it 'play a game'

  end

end