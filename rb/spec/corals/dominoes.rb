define defaults: {
  rules: [
    { when: { dominoes: nil }, dominoes: -> { all_dominoes }},
    { when: { table: nil}, table: []},
    { when: { players: nil }, players: -> { Hash[[:front, :left, :right, :player].map { |x| [x, []] }] }},
    { when: { player: nil }, player: :player },
    { when: { knocked: nil }, knocked: [] },
    { given: { _player: -> { players[player] } } },
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
    {
      when: { table: [] },
      domino: -> { _player.pop }
    },
    {
      when: { table: -> { count > 0 } },
      given: { heads: -> { [table.first.first, table.last.last] } },
      domino: -> { _player.delete _player.find &playable }
    },
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
    }
  ]
}

define done: {

}

define controller: {
  rules: [
    { when!: { on: nil }, on: :start },
    { when!: { on: :start }, on: :turn },
    { when!: { on: :turn, domino: nil }, on: :knock, knocked: -> { p knocked + [player]}},
    { when!: { on: :turn }, on: :play },
    { when!: { on: :knock, knocked: -> { count == players.count }}, on: :stuck },
    { when!: { on: :play, _player: []}, on: :won },
    { when!: { on: [:play, :knock] }, on: :turn, player: -> { next_player.call }},
  ]
}

define helpers: {
  rules: [
    {
      given: {
        all_dominoes: -> { (0..9).map { |x| (x..9).map { |y| [x, y] } }.reduce :+ },
        pick: -> { -> count { (1..count).map { dominoes.pop } } },
        playable: -> { -> domino { not (domino & heads).empty? } },
        order_of_play: [:player, :right, :front, :left, :player],
        next_player: -> { -> { order_of_play[order_of_play.find_index(player) + 1] }}
      }
    }
  ]
}

define rules: {
  rules: [
    { when: { rules: [:dominoes] }, dominoes: true },
    { when: { dominoes: true }, rules: [:helpers, :defaults] },
    { when: { on: [:start, :turn, :play] }, rules: -> { rules + [on] } },
    { when: { on: [:won, :stuck] }, rules: -> { rules + [:done] } },
    { when: { dominoes: true }, rules: -> { rules + [:controller]}}
  ]
}