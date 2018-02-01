define mastermind: {
  rules: [
    {
      given: {
        attempt: -> { guess.zip solution },
        blacks: -> { attempt.select{|x,y|x==y}.count },
        missed: -> { attempt.select{|x,y|x!=y}.transpose },
        misplaced: -> { missed.reduce :& },
        count_per_color: -> { -> color { missed.map {|x| x.count color }.min } },
        whites: -> { misplaced.map(&count_per_color).reduce :+},
      },
      feedback: -> { [:black] * blacks + [:white] * whites }
    }
  ]
}
