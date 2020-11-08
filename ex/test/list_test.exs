defmodule ResolveTest do
  use ExUnit.Case

  import Corals.Resolver

  test "minimal" do
    rules = [hello: :world]
    assert resolve(rules) == %{hello: :world}
  end

end
