defmodule CoralsTest do
  use ExUnit.Case

  test "single value" do

    Corals.define :hello_world, rules: [
      "hello world"
    ]

    assert Corals.resolve == "hello world"

  end

end
