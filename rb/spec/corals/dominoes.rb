define defaults: {
  rules: [
    { when: { table: nil }, table: []},
    { when: { players: nil }, players: [:player, :right, :front, :left].map {|x| { name: x }}}
    # { when: { player: nil }, player: :player },
    # { given: { player_dominoes: -> { players[player][:dominoes] } } },
  ]
}

define start: {
  rules: [
    {
      table: [],
      dominoes: -> { all_dominoes.shuffle },
      players: { dominoes: -> { pick.(10) }},
    }
  ]
}

define turn: {
  rules: [
    {
      when: { table: [] },
      domino: -> { player[:dominoes].pop }
    },
    {
      when: { table: -> { count > 0 } },
      domino: -> { player[:dominoes].delete player[:dominoes].find &playable }
    },
  ]
}

define play: {
  rules: [
    {
      when!: { table: [] },
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
    }
  ]
}

define done: {
  rules: [
    {
      when: { on: :done },
      players: { score: -> { dominoes.flatten.reduce :+ }},
    },
    {
      when: { on: :done },
      players: -> { sort { |x, y| x[:score] <=> y[:score]}},
      winner: -> { players.first }
    }
  ]
}

define controller: {
  rules: [
    { when!: { on: nil }, on: :start },
    { when!: { on: :start }, on: :turn, player: -> { players.first } },
    { when!: { on: :turn, domino: nil }, on: :knock },
    { when!: { on: :turn }, on: :play },
    { when!: { on: :knock, players: -> { players.all? { |x| x[:knocked] }}}, on: :stuck },
    { when!: { on: :play, player: { dominoes: []}}, on: :won },
    { when!: { on: [:play, :knock] }, on: :turn, player: -> { next_player.call }},
  ]
}

define helpers: {
  rules: [
    {
      given: {
        all_dominoes: -> { (0..9).map { |x| (x..9).map { |y| [x, y] } }.reduce :+ },
        pick: -> { -> count { (1..count).map { dominoes.pop } } },
        heads: -> { table.empty? ? [] : [table.first.first, table.last.last]},
        playable: -> { -> domino { not (domino & heads).empty? } },
        order_of_play: [:player, :right, :front, :left, :player],
        next_player: -> { -> { players.find { |x| x[:name] == order_of_play[order_of_play.find_index(player[:name]) + 1] }}}
      }
    }
  ]
}

define rules: {
  rules: [
    { when: { rules: [:dominoes] }, rules: [:defaults, :helpers] },
    { when: { on: [:start, :turn, :play] }, rules: -> { rules + [on] } },
    { when: { on: [:won, :stuck, :done] }, rules: -> { rules + [:done] } },
    { rules: -> { rules + [:controller] }}
  ]
}