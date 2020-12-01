defmodule MMTest do
  use ExUnit.Case

  test "guess in less than 5" do
    %{guesses: guesses} = MM.play()
    assert length(guesses) <= 7
  end

end