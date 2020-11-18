defmodule SingleTest do
  use ExUnit.Case, async: true

  import Corals.Resolver

  test "single" do
    rules = [hello: :world]
    assert resolve(rules) == %{hello: :world}
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

  @tag :wip
  test "list" do
    rules = [
      names: [
        full_name: fn %{name: name, last_name: last_name} -> "#{name} #{last_name}" end
      ]
    ]
    opts = %{
      the_beatles: [
        %{name: "John", last_name: "Lennon"},
        %{name: "Paul", last_name: "McCartney"},
        %{name: "George", last_name: "Harrison"},
        %{name: "Ringo", last_name: "Starr"},
      ]
    }
    assert resolve(rules).the_beatles == [
      %{name: "John", last_name: "Lennon", full_name: "John Lennon"},
      %{name: "Paul", last_name: "McCartney", full_name: "Paul McCartney"},
      %{name: "George", last_name: "Harrison", full_name: "George Harrison"},
      %{name: "Ringo", last_name: "Starr", full_name: "Ringo Starr"},
    ]
  end

end
