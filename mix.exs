defmodule CloseEnough.Mixfile do
  use Mix.Project

  def project do
    [app: :close_enough,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     description: description,
     deps: deps]
  end

  defp description do
    """
    Forget typos in function names name, CloseEnough handles them.
    """
  end

  defp package do
    [
      maintainers: ["Sushruth S"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/sivsushruth/close_enough"}
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end
end
