define dominoes: {
  require: [:helpers, :defaults, :start, :turn]
}

define defaults: {
  rules: [
    {
      dominoes: -> { all_dominoes },
      table: [],
      players: -> { Hash[[:front,:left,:right,:player].map {|x|[x,[]]}] }
    }
  ]
}

define start: {
  rules: [
    {
      when: { on: :start },
      table: [],
      dominoes: -> { all_dominoes.shuffle },
      players: -> { map {|k, _| [k, pick.(10)]}}
    }
  ]
}

define turn: {
  rules: [
    {
      when: { on: :turn },
      given: { player!: -> { players[player] }}
    },
    {
      when: { on: :turn, table: [] },
      domino: -> { player.pop }
    },
    {
      when: { on: :turn, table: -> { count > 0 } },
      given: { heads: -> { [table.first.first, table.last.last] }},
      domino: -> { player.delete player.find &playable }
    },
    { when: { on: :turn, domino: -> { not nil? }}, on!: :play },
    { when: { on: :turn, domino: nil}, on!: :knock }
  ]
}

define helpers: {
  rules: [
    {
      given: {
        all_dominoes: -> { (0..9).map{|x|(x..9).map{|y|[x,y]}}.reduce :+ },
        pick: -> { -> count { (1..count).map { dominoes.pop }}},
        playable: -> { -> domino { not (domino & heads).empty? }}
      }
    }
  ]
}