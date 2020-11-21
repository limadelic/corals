defmodule PrivateTest do
  use ExUnit.Case, async: true

  import Corals.Resolver

  test "single" do
    rules = [
      _private: :stuff,
      hello: :world
    ]
    assert %{} |> resolve(rules) == %{hello: :world}
  end

  test "nested" do
    rules = [
      say: [
        _private: :stuff,
        hello: :world
      ]
    ]
    assert %{} |> resolve(rules) == %{say: %{hello: :world}}
  end

  test "use" do
    rules = [
      [_x: 1, _y: 1],
      [sum: fn %{_x: x, _y: y} -> x + y end]
    ]
    assert %{} |> resolve(rules) == %{sum: 2}
  end

  test "opts" do
    opts = %{_x: 1, _y: 1}
    rules = [[sum: fn %{_x: x, _y: y} -> x + y end]]
    assert opts |> resolve(rules) == %{sum: 2}
  end

end
