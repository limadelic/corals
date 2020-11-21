defmodule NestedTest do
  use ExUnit.Case, async: true

  import Corals.Resolver

  test "not nested" do
    rules = [say: [:hello, :world]]
    assert %{} |> resolve(rules) == %{say: [:hello, :world]}
  end

  test "single" do
    rules = [say: [hello: :world]]
    assert %{} |> resolve(rules) == %{say: %{hello: :world}}
  end

  test "deeper" do
    rules = [say: [that: [hello: :world]]]
    assert %{} |> resolve(rules) == %{say: %{that: %{hello: :world}}}
  end

  test "context" do
    rules = [
      calc: [
        [x: 1, y: 2],
        [sum: fn %{x: x, y: y} -> x + y end]
      ]
    ]
    assert %{} |> resolve(rules) == %{calc: %{x: 1, y: 2, sum: 3}}
  end

  test "deep merged" do
    rules = [
      [calc: [units: "cm"]],
      [calc: [x: 1, y: 2]]
    ]
    assert %{} |> resolve(rules) == %{calc: %{x: 1, y: 2, units: "cm"}}
  end

  test "many w/ context" do
    rules = [
      [calc: [units: "cm"]],
      [calc: [
        [x: 1, y: 2],
        [sum: fn %{x: x, y: y, units: u} -> "#{x + y} #{u}" end]
      ]]
    ]
    assert %{} |> resolve(rules) == %{calc: %{x: 1, y: 2, units: "cm", sum: "3 cm"}}
  end

end
