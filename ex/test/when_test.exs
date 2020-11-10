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

end
