define dominoes: {
  require: [:helpers],
  rules: [
    {
      dominoes: -> { all_dominoes },
      table: [],
      players: {
        front: [],
        left: [],
        right: [],
        player: []
      }
    },
    {
      when: { on: :start },
      table: [],
      dominoes: -> { all_dominoes.shuffle },
      players: -> { map {|k, _| [k, pick.(10)]}}
    },
    {
      when: { on: :turn },
      table!: -> { push players[player].pop }
    }
  ]
}


define helpers: {
  rules: [
    {
      given: {
        all_dominoes: -> { (0..9).map{|x|(x..9).map{|y|[x,y]}}.reduce :+ },
        pick: -> { -> count { (1..count).map { dominoes.pop }}}
      }
    }
  ]
}