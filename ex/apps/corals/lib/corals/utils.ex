defmodule Corals.Utils do

  import Corals.Helpers
  import Map, only: [drop: 2]

  def cont_single? %{_halt_: _} = context do {:halt, drop(context, [:_halt_])} end
  def cont_single? context do {:cont, context} end
  def cont_many? %{__halt__: _} = context do {:halt, drop(context, [:__halt__])} end
  def cont_many? context do {:cont, context} end

  def clean result do drop_deep result, ~r/^_/ end

  def is_corals? p do match? {Corals.Server, _, _}, p[:dictionary][:"$initial_call"] end

end