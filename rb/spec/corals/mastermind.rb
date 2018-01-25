define mastermind: {
  rules: [
    {
      feedback: [],
    },
    {
      guess: {
        when: -> (color) { solution.include? color },
        then: -> { feedback << :white }
      }
    }
  ]
}
