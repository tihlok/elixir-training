defmodule Leaderboard.MixProject do
  use Mix.Project

  def project do
    [
      app: :leaderboard,
      version: "1.0.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: :leadearboard,
      source_url: "",
      docs: [
        main: "Leaderboard Service",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [
        :logger,
        :httpoison
      ]
    ]
  end

  def deps do
    [
      {:ex_doc, "~> 0.25.1", only: :dev, runtime: false},
      {:httpoison, "~> 1.8.0"},
      {:json, "~> 1.4.1"},
      {:git_hooks, "~> 0.6.3", only: [:dev], runtime: false}
    ]
  end
end
