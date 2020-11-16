defmodule ManyTest do
  use ExUnit.Case, async: true

  import Corals.Resolver

  test "single" do
    rules = [
      [hello: :world]
    ]
    assert resolve(rules) == %{hello: :world}
  end

  test "dups" do
    rules = [
      [hello: :world],
      [hello: :there]
    ]
    assert resolve(rules) == %{hello: :there}
  end

  test "two" do
    rules = [
      [hello: :world],
      [hi: :there]
    ]
    assert resolve(rules) == %{hello: :world, hi: :there}
  end

  test "context" do
    rules = [
      [x: 1, y: 1],
      [sum: fn %{x: x, y: y} -> x + y end]
    ]
    assert resolve(rules) == %{x: 1, y: 1, sum: 2}
  end

  @tag :wip
  test "globals" do
    rules = [
      [global: :value],
      [
        local: [
          access: fn _, %{global: value} -> value end
        ]
      ]
    ]
    assert resolve(rules).local.access == :value
  end

end
