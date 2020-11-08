defmodule Corals.Resolver do

  def resolve rules do
    Enum.into rules, %{}
  end

end