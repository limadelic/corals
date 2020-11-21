defmodule UserOptsTest do
  use ExUnit.Case, async: true

  import Corals.Resolver

  test "passthru" do
    user_optss = %{hello: :world}
    assert resolve([],user_optss) == %{hello: :world}
  end

  test "use" do
    user_optss = %{name: :neo}
    rules = [hello: fn %{name: name} -> name end]
    assert resolve(rules, user_optss) == %{name: :neo, hello: :neo}
  end

  test "respect" do
    user_optss = %{name: :neo}
    rules = [name: :noe]
    assert resolve(rules, user_optss) == %{name: :neo}
  end

  test "respect lists" do
    user_optss = %{names: [:neo]}
    rules = [names: [:noe]]
    assert resolve(rules, user_optss) == %{names: [:neo]}
  end

  test "override" do
    user_optss = %{name: :neo}
    rules = [name!: :new]
    assert resolve(rules, user_optss) == %{name: :new}
  end

  test "respect nested" do
    user_optss = %{who?: %{name: :neo}}
    rules = [who?: [name: :noe]]
    assert resolve(rules, user_optss) == %{who?: %{name: :neo}}
  end

  test "override nested" do
    user_optss = %{who?: %{name: :neo}}
    rules = [who?: [name!: :new]]
    assert resolve(rules, user_optss) == %{who?: %{name: :new}}
  end

end
