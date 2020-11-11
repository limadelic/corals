defmodule WhenTest do
  use ExUnit.Case, async: true

  import Corals.Resolver

  test "true" do
    rules = [
      when: true,
      hello: :world
    ]
    assert resolve(rules) == %{hello: :world}
  end

  test "false" do
    rules = [
      when: false,
      hello: :world
    ]
    assert resolve(rules) == %{}
  end

  test "fun" do
    rules = [
      when: fn -> true end,
      hello: :world
    ]
    assert resolve(rules) == %{hello: :world}
  end

  test "not fun" do
    rules = [
      when: fn -> false end,
      hello: :world
    ]
    assert resolve(rules) == %{}
  end

end
