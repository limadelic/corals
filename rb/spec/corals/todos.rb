define todos: {
  rules: [
    { todos: [], completed: [] },
    {
      when: -> { has? :add },
      todos!: -> { todos + [add] }
    },
    {
      when: -> { has? :done },
      todos!: -> { todos - [done] },
      completed!: -> { completed +  [done] }
    }
  ]
}
