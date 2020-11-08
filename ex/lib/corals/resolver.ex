defmodule Corals.Resolver do

  def resolve rules do
    Enum.at rules, 0
  end

end