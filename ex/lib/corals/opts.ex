defmodule Corals.Opts do

  import Corals.Helpers

  defguard is_opt?(opt, opts) when :erlang.is_map_key(opt, opts)

  def is_overridden? opt do ends_with? opt, "!" end
  def overridden opt do "#{opt}" |> String.slice(0..-2) |> String.to_atom end

end