defmodule Corals.Expander do

  alias Corals.Resolver

  import Corals.{When, UserOpts, Fun}

  def expand {:when, cond}, opts, _, globals do do_when cond, opts, globals end
  def expand {:when!, cond}, opts, _, globals do do_when! cond, opts, globals end

  def expand({k, v}, opts, user_opts, globals) when is_list v do
    {k,  Resolver.resolve_raw(opts[k] || %{}, v, user_opts[k] || %{}, globals)}
  end

  def expand({k, _}, opts, user_opts, _) when is_user_opt? k, user_opts do opts end

  def expand({k, f}, opts, _, globals) when is_function f do
    user_opt_value {k, fun({k,f}, opts, globals)}
  end

  def expand tuple, _, _, _ do user_opt_value tuple end

end