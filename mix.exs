defmodule TreehouseClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :treehouse_client,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      env: [treehouse_url: "https://treehouse.maplegum.com/admin/api"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:neuron, "~> 0.5.1"}
    ]
  end
end
