define mastermind: {
  rules: [
    {
      given: {
        attempt: -> { guess.zip solution },
        same: -> { -> x, y { x == y }},
        diff: -> { -> x, y { x != y }},
      }
    },
    {
      given: {
        blacks: -> { attempt.select(&same).count },
      }
    },
    {
      given: {
        missed: -> { attempt.select(&diff).transpose },
        count_per_color: -> { -> color { missed.map {|x| x.count color }.min } },
        whites: -> { missed.reduce(:&).map(&count_per_color).reduce 0, :+},
      }
    },
    {
      feedback: -> { [:black] * blacks + [:white] * whites }
    }
  ]
}
