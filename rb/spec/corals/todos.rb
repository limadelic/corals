define todos: {
  rules: [
    { when: { todos: nil }, todos:[] },
    { when: { completed: nil }, completed:[] },
    {
      when: -> { has? :add },
      todos: -> { todos + [add] }
    },
    {
      when: -> { has? :done },
      todos: -> { todos - [done] },
      completed: -> { completed + [done] }
    },
    {
      when: -> { has? :undo },
      todos: -> { todos + [undo] },
      completed: -> { completed - [undo] }
    }
  ]
}
