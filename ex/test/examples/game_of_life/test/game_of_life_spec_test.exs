defmodule GoLSpecTest do
  use ExUnit.Case, async: true

  describe "death" do

    @death [
      "     ",
      "     ",
      "     "
    ]

    test "dead stays dead" do
      assert @death == GoL.evolve @death
    end

    test "lonely cell dies" do
      cells = [
        "     ",
        "  ▊  ",
        "     "
      ]
      assert @death == GoL.evolve cells
    end

    test "isolated pair dies" do
      cells = [
        "▊    ",
        " ▊   ",
        "     "
      ]
      assert @death == GoL.evolve cells
    end

  end

  describe "survive in numbers" do

    test "cluster" do
      cells = [
        "▊▊ ",
        "▊▊ ",
        "   "
      ]
      assert cells == GoL.evolve cells
    end

    test "rect angle" do
      cells = [
        "▊  ",
        "▊  ",
        "▊▊▊"
      ]
      result = [
        "   ",
        "▊  ",
        "▊▊ "
      ]
      assert result == GoL.evolve cells
    end

  end

  describe "overcrowding" do

    test "only the corners survive" do
      cells = [
        "▊▊▊",
        "▊▊▊",
        "▊▊▊"
      ]
      result = [
        "▊ ▊",
        "   ",
        "▊ ▊"
      ]
      assert result == GoL.evolve cells
    end

  end

  describe "reproduction" do

    test "triangle" do
      cells = [
        "▊ ▊",
        "   ",
        " ▊ "
      ]
      result = [
        "   ",
        " ▊ ",
        "   "
      ]
      assert result == GoL.evolve cells
    end

    test "diamond" do
      cells = [
        " ▊ ▊ ",
        "  ▊  ",
        " ▊ ▊ "
      ]
      result = [
        "  ▊  ",
        " ▊ ▊ ",
        "  ▊  "
      ]
      assert result == GoL.evolve cells
    end

  end

end