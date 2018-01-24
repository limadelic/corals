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
      completed!: -> { completed + [done] }
    },
    {
      when: -> { has? :undo },
      todos!: -> { todos + [undo] },
      completed!: -> { completed - [undo] }
    }
  ]
}
