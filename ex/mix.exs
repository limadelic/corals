defmodule Ex.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases()
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:distillery, "2.1.1"}
    ]
  end

  defp releases do
    [
      corals: [
        version: "0.0.1",
        applications: [
          reef: :permanent
        ]
      ]
    ]
  end
end
