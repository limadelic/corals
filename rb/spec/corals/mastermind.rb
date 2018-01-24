define mastermind: {
  rules: [
    {
      feedback: [],
      guess: []
    },
    {
      guess: {
        when: -> (color) { solution.include? color },
        # then: -> { feedback << :white }
      }
    }
  ]
}
