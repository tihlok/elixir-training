defmodule RpgWeb.PageController do
  use RpgWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
