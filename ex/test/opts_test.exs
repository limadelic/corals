defmodule OptsTest do
  use ExUnit.Case, async: true

  import Corals.Resolver

  test "passthru" do
    opts = %{hello: :world}
    assert resolve([],opts) == %{hello: :world}
  end

  test "use" do
    opts = %{name: :neo}
    rules = [hello: fn %{name: name} -> name end]
    assert resolve(rules, opts) == %{name: :neo, hello: :neo}
  end

  test "respect" do
    opts = %{name: :neo}
    rules = [name: :noe]
    assert resolve(rules, opts) == %{name: :neo}
  end

  test "override" do
    opts = %{name: :neo}
    rules = [name!: :new]
    assert resolve(rules, opts) == %{name: :new}
  end

end
