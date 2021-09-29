defmodule RPGWeb.UserController do
  use RPGWeb, :controller

  alias RPG.Accounts
  alias RPG.Accounts.User

  plug :authenthicate when action in [:index, :show]

  defp authenthicate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "ACCESS RESTRICTED!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    # if conn.assigns.current_user.id == id do
    user = Accounts.get_user(id)
    render(conn, "show.html", user: user)
    # else
    # conn
    # |> put_flash(:error, "MISSING PERMISSION TO SHOW ANOTHER USERS DETAILS!")
    # |> redirect(to: Routes.user_path(conn, :index))
    # |> halt()
    # end
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> RPGWeb.Auth.login(user)
        |> put_flash(:info, "#{user.username} created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
