defmodule Corals.Fun do

  import Function, only: [info: 2]

  def fun f, context, globals do do_fun f, context, globals, info(f, :arity) end

  defp do_fun f, context, globals, {_, 2} do f.(context, globals) end
  defp do_fun f, context, _, {_, 1} do f.(context) end
  defp do_fun f, _, _, _ do f.() end

end