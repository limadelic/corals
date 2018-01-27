define mastermind: {
  rules: [
    {
      given: {
        # attempt: { guess: { zip: :solution} },
        attempt: -> { guess.zip solution },
        same: -> { -> (x, y) { x == y }},
        diff: -> { -> (x, y) { x != y }},
      }
    },
    {
      given: {
        # blacks: { attempt: { select: :==, count: _ }},
        blacks: -> { attempt.select(&same).count },
      }
    },
    {
      given: {
        # missed: { attempt: { select: :!=, transpose: _ },
        missed: -> { attempt.select(&diff).transpose },
        # misplaced: { missed: { reduce: :& }},
        misplaced: -> { missed.reduce :& },
        # count_per_color: -> (color) {{ missed: { map: {|x| x.count color }.min } }},
        count_per_color: -> { -> (color) { missed.map {|x| x.count color }.min } },
        whites: -> { misplaced.map(&count_per_color).reduce 0, :+},
      }
    },
    {
      feedback: -> { [:black] * blacks + [:white] * whites }
    }
  ]
}
