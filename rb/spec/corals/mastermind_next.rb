define mastermind: {
  rules: [
    {
      given: {
        attempt: { guess: { zip: :solution}},
        blacks: { attempt: { select: :==, count: _ }},
        missed: { attempt: { select: :!=, transpose: _ }},
        count_per_color: -> color {{ missed: { map: { count: color }, min: _ }}},
        whites: { missed: { reduce: :& }, map: :count_per_color, reduce: [0, :+]}
      },
      feedback: -> { [:black] * blacks + [:white] * whites }
    }
  ]
}
