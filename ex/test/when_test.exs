defmodule WhenTest do
  use ExUnit.Case, async: true

  import Corals.Resolver

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

end
