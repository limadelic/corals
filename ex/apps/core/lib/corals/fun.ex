defmodule Corals.Fun do

  import Corals.Helpers
  import Function, only: [info: 2]

  @prefix "_@"

  def fun {k, f}, context, globals do
    if is_fun? k do f else fun f, context, globals end
  end
  def fun f, context, globals do do_fun f, context, globals, info(f, :arity) end

  defp is_fun? name do name |> starts_with?(@prefix) end
  defp do_fun f, context, globals, {_, 2} do f.(context, globals) end
  defp do_fun f, context, _, {_, 1} do f.(context) end
  defp do_fun f, _, _, _ do f.() end

end