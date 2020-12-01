defmodule Corals do
  alias Corals.Rules

  import Corals.Fun

  def define name, spec \\ %{} do
    Rules.define name, spec
  end

  def resolve opts, rules, user_opts \\ %{} do
    Rules.resolve opts, rules, user_opts
  end

  defmacro is? pattern do
    quote do
      fn unquote(pattern) -> true; _ -> false end
    end
  end

  defmacro is? opts_pattern, globals_pattern do
    quote do
      fn
        unquote(opts_pattern), unquote(globals_pattern) -> true
        _, _ -> false
      end
    end
  end

  defmacro not? pattern do
    quote do
      fn unquote(pattern) -> false; _ -> true end
    end
  end

  defmacro not? opts_pattern, globals_pattern do
    quote do
      fn
        unquote(opts_pattern), unquote(globals_pattern) -> false
        _, _ -> true
      end
    end
  end

  defmacro either? matchers do
    quote do
      fn opts, globals -> unquote(matchers) |> Enum.any?(&(fun &1, opts, globals)) end
    end
  end

  defmacro neither? matchers do
    quote do
      fn opts, globals -> unquote(matchers) |> Enum.all?(&(not fun &1, opts, globals)) end
    end
  end

end
