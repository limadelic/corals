defmodule GoLSpecTest do
  use ExUnit.Case, async: true

  import Corals

  describe "death" do

    @death [
      0, 0, 0,
      0, 0, 0,
      0, 0, 0
    ]

    @tag :wip
    test "dead stays dead" do
      assert @death == %{cells: @death} |> resolve(GoL)
    end

  end

end