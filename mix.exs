defmodule Seraphine.MixProject do
  use Mix.Project

  def project do
    [
      app: :seraphine,
      name: "Seraphine",
      version: "0.1.4",
      elixir: "~> 1.13",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: "Seraphine is an API library for the Riot Games API. More specifically the League of Legends part of the API only.",
      deps: deps(),
      package: package(),
      docs: [extras: ["README.md"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Tristan Farkas"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/trilleplay/seraphine"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:poison, "~> 5.0"},
      {:semaphore, "~> 1.3"},
      {:fastglobal, "~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
