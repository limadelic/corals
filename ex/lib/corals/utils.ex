defmodule Corals.Utils do

  def p x \\ nil do IO.puts x end
  def w x do IO.write x end
  def i x do IO.inspect x end
  def i tag, x do w "#{tag}: "; i x end
  def l tag, x, context do
    i tag, x
    i :context, context
    p ""
  end

  def ends_with? x, suffix do String.match? "#{x}", ~r/#{suffix}$/ end

  def merge map, {k, v} do merge map, %{k => v} end
  def merge left, right do Map.merge left, right, &deep/3 end

  defp deep _, left=%{}, right=%{} do merge left, right end
  defp deep _, _, right do right end

end