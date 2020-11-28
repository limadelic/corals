defmodule Corals do
  alias Corals.Rules

  import Macro, only: [escape: 1]

  def define name, spec \\ %{} do
    Rules.define name, spec
  end

  def resolve opts, rules, user_opts \\ %{} do
    Rules.resolve opts, rules, user_opts
  end

  defmacro is? opts_pattern, globals_pattern \\ escape(%{}) do
    quote do
      fn opts, globals ->
        match?(unquote(opts_pattern), opts) and
        match?(unquote(globals_pattern), globals)
      end
    end
  end

  defmacro not? opts_pattern, globals_pattern \\ escape(%{}) do
    quote do
      fn opts, globals ->
        not match?(unquote(opts_pattern), opts) or
        not match?(unquote(globals_pattern), globals)
      end
    end
  end

  defmacro either? opts_patterns do
    quote do
      fn unquote(opts_patterns) -> true; _ -> false end
    end
  end

end
