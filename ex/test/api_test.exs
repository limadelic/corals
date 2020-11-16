defmodule ApiTest do
  use ExUnit.Case
  import Corals

  test "one rule" do

    define :hello_world, %{
      rules: [ hello: :world ]
    }

    assert resolve(:hello_world) == %{hello: :world}
  end

  test "two rules" do

    define :hello_world, %{
      rules: [ hello: :world ]
    }
    define :sup, %{
      rules: [ yo: :sup ]
    }

    assert resolve(:sup) == %{yo: :sup}
  end

end
