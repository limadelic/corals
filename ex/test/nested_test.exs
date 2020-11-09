defmodule NestedTest do
  use ExUnit.Case, async: true

  import Corals.Resolver

  test "single" do
    rules = [say: [hello: :world]]
    assert resolve(rules) == %{say: %{hello: :world}}
  end

end
