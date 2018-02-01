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
      players: -> x { x.map {|k, _| [k, 10]}}
    }
  ]
}


define helpers: {
  rules: [
    {
      given: {
        all_dominoes: -> { (0..9).map{|x|(x..9).map{|y|[x,y]}}.reduce :+ },
        # take: -> count { }
      }
    }
  ]
}