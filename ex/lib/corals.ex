defmodule Corals do
  alias Corals.Rules

  def define name, spec \\ %{} do
    Rules.define name, spec
  end

  def resolve opts, rules, user_opts \\ %{} do
    Rules.resolve opts, rules, user_opts
  end

  defmacro is? opts_pattern do
    quote do
      fn unquote(opts_pattern) -> true; _ -> false end
    end
  end

  defmacro is? opts_pattern, global_pattern  do
    quote do
      fn unquote(opts_pattern), unquote(global_pattern) -> true; _, _ -> false end
    end
  end

  defmacro not? opts_pattern do
    quote do
      fn unquote(opts_pattern) -> false; _ -> true end
    end
  end

  defmacro not? opts_pattern, global_pattern  do
    quote do
      fn unquote(opts_pattern), unquote(global_pattern) -> false; _, _ -> true end
    end
  end

end
