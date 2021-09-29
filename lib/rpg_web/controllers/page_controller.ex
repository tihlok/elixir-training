defmodule RPGWeb.PageController do
  use RPGWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
