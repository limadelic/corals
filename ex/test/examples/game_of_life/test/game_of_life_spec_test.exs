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

    test "lonely cell dies" do
      cells = [
        0, 0, 0,
        0, 1, 0,
        0, 0, 0
      ]
      assert @death == resolve(%{cells: cells}, GoL).cells
    end

    test "isolated pair dies" do
      cells = [
        1, 0, 0,
        0, 1, 0,
        0, 0, 0
      ]
      assert @death == resolve(%{cells: cells}, GoL).cells
    end

  end

  describe "survive in numbers" do

    test "cluster" do
      cluster = [
        1, 1, 0,
        1, 1, 0,
        0, 0, 0
      ]
      assert cluster == resolve(%{cells: cluster}, GoL).cells
    end

    test "rect angle" do
      cells = [
        1, 0, 0,
        1, 0, 0,
        1, 1, 1
      ]
      result = [
        0, 0, 0,
        1, 0, 0,
        1, 1, 0
      ]
      assert result == resolve(%{cells: cells}, GoL).cells
    end

  end

  describe "overcrowding" do

    test "only the corners survive" do
      cells = [
        1, 1, 1,
        1, 1, 1,
        1, 1, 1
      ]
      result = [
        1, 0, 1,
        0, 0, 0,
        1, 0, 1
      ]
      assert result == resolve(%{cells: cells}, GoL).cells
    end

  end

end