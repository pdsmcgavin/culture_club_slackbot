defmodule CultureClubSlackbot.MixProject do
  use Mix.Project

  def project do
    [
      app: :culture_club_slackbot,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :slack],
      mod: {CultureClubSlackbot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:slack, "~> 0.14.0"}]
  end
end
