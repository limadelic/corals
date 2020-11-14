defmodule Corals.Resolver do

  import Corals.Many
  import Corals.Single

  def resolve rules, opts \\ %{} do
    resolve rules, opts, opts
  end

  def resolve rules, context, opts do
    cond do
      are_many? rules -> many rules, context, opts
      is_single? rules -> single rules, context, opts
      opts != %{} -> opts
      true -> rules
    end
  end

  def are_rules? rules do is_list(rules) && (is_single?(rules) || are_many?(rules)) end

end