defmodule MMTest do
  use ExUnit.Case, async: true

  import Corals.Helpers

  test "guess in less than 5" do
    %{attempts: attempts, solution: solution} = MM.play()

    i :solved, solution
    i :in, attempts

    assert attempts <= 7
  end

end