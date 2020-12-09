defmodule MM.ScoreTest do
  use ExUnit.Case, async: true

  import Corals

  @solution [:red, :green, :blue, :yellow]

  def score guess do
    (%{solution: @solution, guess: guess} |> resolve(MM.Score)).score
  end

  test "win with 4 blacks" do
    assert score(@solution) == [:black, :black, :black, :black]
  end

  test "some blacks" do
    assert score([:red, :green, :blue, :green]) == [:black, :black, :black]
  end

  test "some whites" do
    assert score([:pink, :purple, :red, :green]) == [:white, :white]
  end

  test "mixed" do
    assert score([:pink, :green, :red, :yellow]) == [:white, :black, :black]
  end

  test "score nothing" do
    assert score([:pink, :pink, :pink, :pink]) == []
  end

end