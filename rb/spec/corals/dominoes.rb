define dominoes: {
  rules: [
    { when: { dominoes: nil }, dominoes: -> { all_dominoes }},
    { when: { table: nil}, table: []},
    { when: { players: nil }, players: -> { Hash[[:front, :left, :right, :player].map { |x| [x, []] }] }},
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
    { given: { _player: -> { players[player] } } },
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

define controller: {
  rules: [
    { when: { player: nil }, player: :player },
    { when!: { on: nil }, on: :start },
    { when!: { on: :start }, on: :turn },
    { when!: { on: :turn, domino: nil }, on: :knock },
    { when!: { on: :turn }, on: :play },
    {
      when!: { on: :play },
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
    { when: { on: [:start, :turn, :play] }, rules: -> { rules + [on] } },
    { when: { rules: -> { include? :dominoes } }, rules: -> { rules + [:controller]}}
  ]
}