defmodule Corals.Loader do

  import Path, only: [wildcard: 1]
  import Enum, only: [uniq: 1, map: 2, find: 2]
  import String, only: [starts_with?: 2, replace_prefix: 3]

  @corals_files "**/corals/**/*rules.exs"

  def start app do Task.Supervisor.start_child Corals.TaskSupervisor, &run/0; app end

  def run do corals_files() |> map(&Code.require_file/1) end

  def content name do
    corals_files() |> map(&File.read!/1) |> find(&(&1 =~ matcher(name)))
  end

  defp corals_files do @corals_files |> wildcard |> uniq end
  defp matcher name do
    cond do
      starts_with? name, "Elixir." -> ~r/defmodule #{replace_prefix name, "Elixir.", ""}/
      true -> ~r/define.*#{name}/
    end
  end

end