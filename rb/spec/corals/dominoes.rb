define dominoes: {
  require: [:rules]
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
      table: [],
      dominoes: -> { all_dominoes.shuffle },
      players: -> { map {|k, _| [k, pick.(10)]}}
    }
  ]
}

define turn: {
  rules: [
    {
      given: { player!: -> { players[player] }}
    },
    {
      when: { table: [] },
      domino: -> { player.pop }
    },
    {
      when: { table: -> { count > 0 } },
      given: { heads: -> { [table.first.first, table.last.last] }},
      domino: -> { player.delete player.find &playable }
    },
    { when: { domino: -> { not nil? }}, on!: :play },
    { when: { domino: nil}, on!: :knock }
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

define rules: {
  rules: [
    { when: { rules: [:dominoes] }, rules!: [:helpers, :defaults] },
    { when: { on: [:start, :turn]}, rules!: -> { push on }}
  ]
}