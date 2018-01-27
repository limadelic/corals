define mastermind: {
  rules: [
    {
      given: {
        guessed: -> { guess.zip(solution).select { |guess, solution| guess == solution }},
        blacks: -> { guessed.map { :black }},
      }
    },
    {
      given: {
        blacks: {
          zip: [:guess, :solution],
          select: :==,
          map: :black
        }
      }
    },
    {
      given: {
        missed: { zip: [:guess, :solution], select: :!= },
        unknown: { map: [:missed, -> (guess, _) { guess }]},
        unsolved: { map: [:missed, -> (_, solution) { solution }]},
        misplaced: { :& => [:unknown, :unsolved] },
        per_color: -> (color) {{ min: [{ count: [:unknown, color]}, { count: [:unsolved, color]}]}},
        total: { map: [:misplaced, :per_color], reduce: [0, :+] },
        whites: { :* => [[:white], :total] }
      }
    },
    {
      given: {
        missed: -> { guess.zip(solution).select { |guess, solution| guess != solution }},
        unknown: -> { missed.map { |guess, _| guess } },
        unsolved: -> { missed.map { |_, solution| solution }},
        misplaced: -> { unknown & unsolved },
        per_color: -> (color) { [unknown.count(color), unsolved.count(color)].min },
        count: -> { misplaced.map(per_color).reduce 0, :+},
        whites: -> { [:white] * count }
      }
    },
    {
      feedback: -> { blacks + whites }
    }
  ]
}
