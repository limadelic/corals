defmodule ApiTest do
  use ExUnit.Case
  import Corals

  test "one rule" do

    define :hello_world, %{
      rules: [
        hello: :world
      ]
    }

    assert resolve(:hello_world) == %{hello: :world}
  end

  test "two rules" do

    define :hey, %{
      rules: [
        hey: :jude
      ]
    }

    define :sup, %{
      rules: [
        yo: :sup
      ]
    }

    assert resolve([:hey, :sup]) == %{hey: :jude, yo: :sup}
  end

  test "requires" do

    define :hey, %{
      rules: [
        hey: :jude
      ]
    }

    define :sup, %{
      requires: [:hey],
      rules: [
        yo: :sup
      ]
    }

    assert resolve(:sup) == %{hey: :jude, yo: :sup}
  end

end
