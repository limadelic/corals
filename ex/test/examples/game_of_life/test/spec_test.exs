defmodule GoLSpecs do
  use ExUnit.Case, async: true

  def verify expected, actual do
   assert expected == GoL.evolve(%{cells: actual}).cells
  end

  describe "death" do

    @death [
      "   ",
      "   ",
      "   "
    ]

    test "dead stays dead" do
      verify @death, @death
    end

    test "lonely cell dies" do
      cells = [
        "   ",
        " ▊ ",
        "   "
      ]
     verify @death, cells
    end

    test "isolated pair dies" do
      cells = [
        "▊  ",
        " ▊ ",
        "   "
      ]
     verify @death, cells
    end

  end

  describe "survive in numbers" do

    test "cluster" do
      cells = [
        "▊▊ ",
        "▊▊ ",
        "   "
      ]
     verify cells, cells
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
     verify result, cells
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
     verify result, cells
    end

  end

  describe "reproduction" do

    test "triangle" do
      cells = [
        " ▊ ▊ ",
        "     ",
        "  ▊  "
      ]
      result = [
        "     ",
        "  ▊  ",
        "     "
      ]
     verify result, cells
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
     verify result, cells
    end

  end

end