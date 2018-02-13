define mastermind: {
  rules: [
    {
      given: {
        attempt: { guess: { zip: :solution}},
        blacks: { attempt: { select: :==, count: _ }},
        missed: { attempt: { select: :!=, transpose: _ }},
        misplaced: { missed: { reduce: :& }},
        count_per_color: [ :color, { missed: { map: { count: :color }, min: _ }}],
        whites: { misplaced: { map: :count_per_color, reduce: :+}}
      },
      feedback: -> { [:black] * blacks + [:white] * whites }
    }
  ]
}
