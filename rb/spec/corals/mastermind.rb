define mastermind: {
  rules: [
    {
      given: {
        attempt: -> { guess.zip solution },
        blacks: -> { attempt.select{|x,y|x==y}.count },
        missed: -> { attempt.select{|x,y|x!=y}.transpose },
        count_per_color: -> { -> color { missed.map {|x| x.count color }.min } },
        whites: -> { missed.reduce(:&).map(&count_per_color).reduce 0, :+},
      }
    },
    {
      feedback: -> { [:black] * blacks + [:white] * whites }
    }
  ]
}
