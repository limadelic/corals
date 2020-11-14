defmodule Corals.Many do

  alias Corals.Resolver
  import Corals.Utils
  import Enum, only: [all?: 2, reduce_while: 3]

  def are_many? rules do all? rules, &Resolver.are_rules?/1 end

  def many rules, context, opts do
    reduce_while rules, context, &(one_of_many(&1, &2, opts))
  end

  defp one_of_many rules, context, opts do
    {:cont, merge(context, Resolver.resolve(rules, context, opts))}
  end

end