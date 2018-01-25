define mastermind: {
  rules: [
    {
      given: {
        guessed: -> { guess.zip(solution).select { |x, y| x == y }},
        blacks: -> { guessed.map { :black }},
      }
    },
    {
      given: {
        missed: -> { guess.zip(solution).select { |x, y| x != y }},
        unknown: -> { missed.map { |guess, _| guess } },
        unsolved: -> { missed.map { |_, solution| solution }},
        misplaced: -> { unknown & unsolved },
        count: -> { misplaced.map { |color| [unknown.count(color), unsolved.count(color)].min }.inject 0, :+},
        whites: -> { [:white] * count }
      }
    },
    {
      feedback: -> { blacks + whites }
    }
  ]
}
