defmodule ApiTest do
  use ExUnit.Case, aync: true

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

    define :one, %{
      rules: [
        one: :value
      ]
    }

    define :two, %{
      rules: [
        another: :value
      ]
    }

    assert resolve([:one, :two]) == %{one: :value, another: :value}
  end

  test "require" do

    define :required, %{
      rules: [
        required: :value
      ]
    }

    define :needy, %{
      require: [:required],
      rules: [
        needed: :value
      ]
    }

    assert resolve(:needy) == %{needed: :value, required: :value}
  end

  test "private across rules" do

    define :private, %{
      rules: [
        _private: :value
      ]
    }

    define :spy, %{
      require: [:private],
      rules: [
        spied: fn %{_private: x} -> x end
      ]
    }

    assert resolve(:spy) == %{spied: :value}
  end

  test "opts" do

    define :opts

    assert resolve(:opts, %{some: :opts}) == %{some: :opts}
  end

end
