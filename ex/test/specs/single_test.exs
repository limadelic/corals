defmodule SingleTest do
  use ExUnit.Case, async: true

  import Corals.Resolver

  test "single" do
    rules = [hello: :world]
    assert resolve(rules) == %{hello: :world}
  end

  test "values" do
    rules = [
      atom: :bomb,
      number: 42,
      bool: true,
      list: [1,2,3],
#      empty_list: [],
      map: %{key: :value},
      empty_map: %{}
    ]

    assert resolve(rules) == %{
      atom: :bomb,
      number: 42,
      bool: true,
      list: [1,2,3],
#      empty_list: [],
      map: %{key: :value},
      empty_map: %{}
    }
  end

  test "dups" do
    rules = [
      hello: :world,
      hello: :there
    ]
    assert resolve(rules) == %{hello: :there}
  end

  test "two" do
    rules = [
      hello: :world,
      hi: :there
    ]
    assert resolve(rules) == %{hello: :world, hi: :there}
  end

  test "lambda" do
    rules = [hello: fn -> :world end]
    assert resolve(rules) == %{hello: :world}
  end

  test "context" do
    rules = [
      x: 1,
      y: 1,
      sum: fn %{x: x, y: y} -> x + y end
    ]
    assert resolve(rules) == %{x: 1, y: 1, sum: 2}
  end

end
