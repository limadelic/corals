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
      assert @death == GoL.evolve @death
    end

    test "lonely cell dies" do
      cells = [
        0, 0, 0,
        0, 1, 0,
        0, 0, 0
      ]
      assert @death == GoL.evolve cells
    end

    test "isolated pair dies" do
      cells = [
        1, 0, 0,
        0, 1, 0,
        0, 0, 0
      ]
      assert @death == GoL.evolve cells
    end

  end

  describe "survive in numbers" do

    test "cluster" do
      cells = [
        1, 1, 0,
        1, 1, 0,
        0, 0, 0
      ]
      assert cells == GoL.evolve cells
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
      assert result == GoL.evolve cells
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
      assert result == GoL.evolve cells
    end

  end

  describe "reproduction" do

    test "triangle" do
      cells = [
        1, 0, 1,
        0, 0, 0,
        0, 1, 0
      ]
      result = [
        0, 0, 0,
        0, 1, 0,
        0, 0, 0
      ]
      assert result == GoL.evolve cells
    end

    test "diamond" do
      cells = [
        1, 0, 1,
        0, 1, 0,
        1, 0, 1
      ]
      result = [
        0, 1, 0,
        1, 0, 1,
        0, 1, 0
      ]
      assert result == GoL.evolve cells
    end

  end

end