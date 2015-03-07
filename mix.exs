defmodule Proximel.Mixfile do
  use Mix.Project

  def project do
    [app: :proximel,
     version: "0.0.1",
     elixir: "~> 1.0"]
  end

  def application do
    [applications: [:logger]]
  end

end
