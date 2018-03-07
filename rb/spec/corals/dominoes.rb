define dominoes: {
  rules: [
    { when: { dominoes: nil }, dominoes: -> { all_dominoes }},
    { when: { table: nil}, table: []},
    { when: { players: nil }, players: -> { Hash[[:front, :left, :right, :player].map { |x| [x, []] }] }},
    { when: { player: nil }, player: :player }
  ]
}

define start: {
  rules: [
    {
      table: [],
      dominoes: -> { all_dominoes.shuffle },
      players: -> { map { |k, _| [k, pick.(10)] } }
    }
  ]
}

define turn: {
  rules: [
    { given: { player: -> { players[player] } } },
    {
      when: { table: [] },
      domino: -> { player.pop }
    },
    {
      when: { table: -> { count > 0 } },
      given: { heads: -> { [table.first.first, table.last.last] } },
      domino: -> { player.delete player.find &playable }
    },
    { when: { domino: -> { not nil? } }, on: :play },
    { when: { domino: nil }, on: :knock }
  ]
}

define play: {
  rules: [
    {
      when!: -> { table.empty? },
      table: -> { [domino] }
    },
    {
      when!: -> { domino.first == table.first.first },
      table: -> { [domino.reverse] + table }
    },
    {
      when!: -> { domino.first == table.last.last },
      table: -> { table + [domino] }
    },
    {
      when!: -> { domino.last == table.first.first },
      table: -> { [domino] + table }
    },
    {
      when!: -> { domino.last == table.last.last },
      table: -> { table + [domino.reverse] }
    },
    {
      given: {
        order_of_play: [:player, :right, :front, :left, :player],
        next_player: -> { order_of_play[order_of_play.find_index(player) + 1] }
      },
      on: :turn, player: -> { next_player }
    }
  ]
}

define helpers: {
  rules: [
    {
      given: {
        all_dominoes: -> { (0..9).map { |x| (x..9).map { |y| [x, y] } }.reduce :+ },
        pick: -> { -> count { (1..count).map { dominoes.pop } } },
        playable: -> { -> domino { not (domino & heads).empty? } }
      }
    }
  ]
}

define rules: {
  rules: [
    { when: { rules: [:dominoes] }, rules: [:helpers, :dominoes] },
    { when: { on: [:start, :turn, :play] }, rules: -> { rules + [on] } }
  ]
}