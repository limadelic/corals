defmodule WhenTest do
  use ExUnit.Case, async: true

  import Corals.Resolver
  import Corals, only: [has?: 1]

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

  describe "has?" do

    test "has key" do
      rules = [
        hello: :world,
        when: has?(%{hello: _}),
        it: :greeted
      ]
      assert resolve(rules) == %{it: :greeted, hello: :world}
    end

    test "has value" do
      rules = [
        hello: :world,
        when: has?(%{hello: :world}),
        it: :greeted
      ]
      assert resolve(rules) == %{it: :greeted, hello: :world}
    end

    test "when" do
      rules = [
        hello: :world,
        when: has?(%{hello: x} when is_atom x),
        it: :greeted
      ]
      assert resolve(rules) == %{it: :greeted, hello: :world}
    end

  end

  describe "many" do

    test "say what?" do
      rules = [
        [when: has?(%{name: _}), say: fn %{name: who} -> "hello #{who}" end],
        [when: has?(%{name: :neo}), say: "the matrix has you"],
      ]

      assert resolve(rules, %{name: :mike}).say == "hello mike"
      assert resolve(rules, %{name: :neo}).say == "the matrix has you"
    end

    test "knock knock" do
      rules = [
        [when: has?(%{name: _}), say: fn %{name: who} -> "hello #{who}" end],
        [when: has?(%{name: :neo}), say: fn %{say: say} -> "#{say} ... the matrix has you" end],
      ]

      assert resolve(rules, %{name: :neo}).say == "hello neo ... the matrix has you"
    end

  end

  describe "shortcut!" do

    test "odd/even" do
      rules = [
        [when!: has?(%{x: x} when rem(x, 2) == 0), its: :even],
        [its: :odd]
      ]

      assert resolve(rules, %{x: 1}).its == :odd
      assert resolve(rules, %{x: 2}).its == :even
    end

  end

end
