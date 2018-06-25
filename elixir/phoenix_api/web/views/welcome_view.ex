defmodule PhoenixApi.WelcomeView do
  use PhoenixApi.Web, :view

  def render("index.json", _assigns) do
    %{
      section: "Creating a simple API using Elixir/Phoenix",
      author: "Ruan"
    }
  end
end
