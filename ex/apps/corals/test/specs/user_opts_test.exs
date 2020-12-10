defmodule UserOptsTest do
  use ExUnit.Case, async: true

  import Corals.Resolver

  test "passthru" do
    user_opts = %{hello: :world}
    assert %{} |> resolve([], user_opts) == %{hello: :world}
  end

  test "use" do
    user_opts = %{name: :neo}
    rules = [hello: fn %{name: name} -> name end]
    assert %{} |> resolve(rules, user_opts) == %{name: :neo, hello: :neo}
  end

  test "respect" do
    user_opts = %{name: :neo}
    rules = [name: :noe]
    assert %{} |> resolve(rules, user_opts) == %{name: :neo}
  end

  test "respect lists" do
    user_opts = %{names: [:neo]}
    rules = [names: [:noe]]
    assert %{} |> resolve(rules, user_opts) == %{names: [:neo]}
  end

  test "override" do
    user_opts = %{name: :neo}
    rules = [name!: :new]
    assert %{} |> resolve(rules, user_opts) == %{name: :new}
  end

  test "respect nested" do
    user_opts = %{who?: %{name: :neo}}
    rules = [who?: [name: :noe]]
    assert %{} |> resolve(rules, user_opts) == %{who?: %{name: :neo}}
  end

  test "override nested" do
    user_opts = %{who?: %{name: :neo}}
    rules = [who?: [name!: :new]]
    assert %{} |> resolve(rules, user_opts) == %{who?: %{name: :new}}
  end

end
