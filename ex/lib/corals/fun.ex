defmodule Corals.Fun do

  import Function, only: [info: 2]

  def fun f, context do do_fun f, context, info(f, :arity) end

  defp do_fun f, context, {_, 1} do f.(context) end
  defp do_fun f, context, _ do f.() end

end