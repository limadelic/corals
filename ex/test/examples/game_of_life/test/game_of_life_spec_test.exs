defmodule GoLSpecTest do
  use ExUnit.Case, async: true

  import Corals

  describe "death" do

    @death [
      0, 0, 0,
      0, 0, 0,
      0, 0, 0
    ]

    test "dead stays dead" do
      assert @death == resolve(%{cells: @death}, GoL).cells
    end

  end

end