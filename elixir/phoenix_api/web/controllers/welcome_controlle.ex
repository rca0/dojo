defmodule PhoenixApi.WelcomeController do
  use PhoenixApi.Web, :controller

  def index(conn, _params) do
    render(conn, "index.json")
  end
end
