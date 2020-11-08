defmodule Corals.Resolver do

  def resolve rules do
    if Keyword.keyword? rules do
      resolve_list rules
    else
      resolve_value rules
    end
  end

  def resolve_value rules do
    Enum.at rules, 0
  end

  def resolve_list rules do
    Enum.into rules, %{}
  end

end