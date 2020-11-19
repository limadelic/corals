defmodule WhenTest do
  use ExUnit.Case, async: true

  import Corals.Resolver
  import Corals, only: [is?: 1]

  describe "before" do

    test "single" do
      rules = [
        try: :to,
        when: false,
        hello: :world
      ]
      assert resolve(rules) == %{try: :to}
    end

    test "single+" do
      rules = [
        try: :to,
        really: :hard,
        when: false,
        hello: :world
      ]
      assert resolve(rules) == %{try: :to, really: :hard}
    end

  end

  describe "pass" do

    test "bool" do
      rules = [
        when: true,
        hello: :world
      ]
      assert resolve(rules) == %{hello: :world}
    end

    test "fun" do
      rules = [
        when: fn -> true end,
        hello: :world
      ]
      assert resolve(rules) == %{hello: :world}
    end

  end

  describe "fail" do

    test "bool" do
      rules = [
        when: false,
        hello: :world
      ]
      assert resolve(rules) == %{}
    end

    test "fun" do
      rules = [
        when: fn -> false end,
        hello: :world
      ]
      assert resolve(rules) == %{}
    end

  end

  describe "is?" do

    test "key" do
      rules = [
        hello: :world,
        when: is?(%{hello: _}),
        it: :greeted
      ]
      assert resolve(rules) == %{it: :greeted, hello: :world}
    end

    test "key from opts" do
      rules = [
        when: is?(%{hello: _}),
        it: :greeted
      ]
      assert resolve(rules, %{hello: :dude}) == %{it: :greeted, hello: :dude}
    end

    test "many" do
      rules = [
        [
          hello: :world
        ],
        [
          when: is?(%{hello: _}),
          it: :greeted
        ]
      ]
      assert resolve(rules) == %{it: :greeted, hello: :world}
    end

    test "many from opts" do
      rules = [
        [
          when: is?(%{hello: :dude}),
          it: :greeted
        ]
      ]
      assert resolve(rules, %{hello: :dude}) == %{it: :greeted, hello: :dude}
    end

    test "value" do
      rules = [
        hello: :world,
        when: is?(%{hello: :world}),
        it: :greeted
      ]
      assert resolve(rules) == %{it: :greeted, hello: :world}
    end

    test "when" do
      rules = [
        hello: :world,
        when: is?(%{hello: x} when is_atom x),
        it: :greeted
      ]
      assert resolve(rules) == %{it: :greeted, hello: :world}
    end

  end

  describe "many" do

    test "say what?" do
      rules = [
        [when: is?(%{name: _}), say: fn %{name: who} -> "hello #{who}" end],
        [when: is?(%{name: :neo}), say: "the matrix has you"],
      ]

      assert resolve(rules, %{name: :mike}).say == "hello mike"
      assert resolve(rules, %{name: :neo}).say == "the matrix has you"
    end

    test "knock knock" do
      rules = [
        [when: is?(%{name: _}), say: fn %{name: who} -> "hello #{who}" end],
        [when: is?(%{name: :neo}), say: fn %{say: say} -> "#{say} ... the matrix has you" end],
      ]

      assert resolve(rules, %{name: :neo}).say == "hello neo ... the matrix has you"
    end

  end

  describe "shortcut!" do

    test "odd/even" do
      rules = [
        [when!: is?(%{x: x} when rem(x, 2) == 0), its: :even],
        [its: :odd]
      ]

      assert resolve(rules, %{x: 1}).its == :odd
      assert resolve(rules, %{x: 2}).its == :even
    end

  end

end
