defmodule ManyTest do
  use ExUnit.Case

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

end
