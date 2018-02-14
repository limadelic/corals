require 'spec_helper'
require_relative '../corals/todos'

describe 'Todo' do

  it 'adds a todo' do

    test :todos,
      when: { add: 'todo' },
      then: { todos: ['todo'] }

  end

  it 'adds another todo' do

    test :todos,
      given: { todos: ['todo1'] },
      when: { add: 'todo2' },
      then: { todos: ['todo1', 'todo2'] }

  end

  it 'gets it done' do

    test :todos,
      given: { todos: ['todo']  },
      when: { done: 'todo' },
      then: { todos:[], completed: ['todo']}

  end

  it 'undoes it' do

    test :todos,
      given: { completed: ['todo']  },
      when: { undo: 'todo' },
      then: { todos:['todo'], completed: []}

  end

end