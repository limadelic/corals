define mastermind: {
  rules: [
    # {
    #   blacks: {
    #     zip: [:guess, :solution],
    #     select: [:==],
    #     count: []
    #   }
    # },
    {
      # given: {
      #   missed: { zip: [:guess, :solution], select: :!= },
      #   unknown: { map: [:missed, -> (guess, _) { guess }]},
      #   unsolved: { map: [:missed, -> (_, solution) { solution }]},
      #   misplaced: { :& => [:unknown, :unsolved] },
      #   per_color: -> (color) {{ min: [{ count: [:unknown, color]}, { count: [:unsolved, color]}]}},
      #   total: { map: [:misplaced, :per_color], reduce: [0, :+] },
      #   whites: { :* => [[:white], :total] }
      # }
    },
    {
      given: {
        same: -> { -> (x,y) { x == y }},
        diff: -> { -> (x,y) { x != y }},
        attempt: -> { guess.zip solution },
        guessed: -> { attempt.select &same },
        missed: -> { attempt.select(&diff).transpose },
        misplaced: -> { missed.reduce :& },
        count_per_color: -> { -> (color) { missed.map {|x| x.count color }.min } },
      }
    },
    {
      blacks: -> { guessed.count },
      whites: -> { misplaced.map(&count_per_color).reduce 0, :+},
      feedback: -> { [:black] * blacks + [:white] * whites }
    }
  ]
}
