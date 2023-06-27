defmodule Mtba.MixProject do
  use Mix.Project

  def project do
    [
      app: :mtba,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:csv, ">= 0.0.0"},
      {:decimal, ">= 0.0.0"}
    ]
  end
end
