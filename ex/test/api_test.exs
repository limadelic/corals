defmodule ApiTest do
  use ExUnit.Case

  test "single rule" do

    Corals.define :hello_world, %{
      rules: [ "hello world"]
    }

    assert Corals.resolve(:hello_world) == "hello world"

  end

end
