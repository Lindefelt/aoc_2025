defmodule Aoc2025.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc_2025,
      version: "0.1.0",
      escript: escript()
    ]
  end

  def escript do
    [main_module: D2]
  end
end
