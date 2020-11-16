defmodule Corals.Utils do

  import Enum, only: [map: 2, into: 2, filter: 2]
  import Map, only: [keys: 1, drop: 2, to_list: 1]

  def p x \\ nil do IO.puts x end
  def w x do IO.write x end
  def i x do IO.inspect x end
  def i tag, x do w "#{tag}: "; i x end
  def l tag, x, context do
    i tag, x
    i :context, context
    p ""
  end

  def cont_single? %{_halt_: _} = context do {:halt, drop(context, [:_halt_])} end
  def cont_single? context do {:cont, context} end
  def cont_many? %{__halt__: _} = context do {:halt, drop(context, [:__halt__])} end
  def cont_many? context do {:cont, context} end

  def ends_with? x, suffix do String.match? "#{x}", ~r/#{suffix}$/ end

  def merge map, {k, v} do merge map, %{k => v} end
  def merge left, right do Map.merge left, right, &deep/3 end

  defp deep _, left=%{}, right=%{} do merge left, right end
  defp deep _, _, right do right end


  def clean result do drop_deep result, ~r/^_/ end
  def drop_deep %{}=map, exp do
    map |> drop(keys(map, exp)) |> to_list |> map(fn {k, v} -> {k, drop_deep(v, exp)} end) |> into(%{})
  end
  def drop_deep x, _ do x end
  defp keys map, exp do map |> keys |> filter(&(String.match? "#{&1}", exp)) end

end