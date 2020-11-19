defmodule StartTest do
  use ExUnit.Case

  import Corals

  @tag :wip
  test "empty table" do
    assert resolve(:game, %{on: :start}).table == []
  end

end